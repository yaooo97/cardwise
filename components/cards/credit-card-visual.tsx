'use client'

import { CreditCard } from '@/types/database'
import { cn } from '@/lib/utils'

// Issuer brand colors
const ISSUER_COLORS: Record<string, { start: string; end: string; logo: string }> = {
  'Chase': { start: '#004977', end: '#003366', logo: '◆' },
  'Amex': { start: '#006fcf', end: '#004080', logo: '▲' },
  'Citi': { start: '#003b70', end: '#002244', logo: '●' },
  'Capital One': { start: '#c41230', end: '#8b0000', logo: '◎' },
  'Bank of America': { start: '#e31837', end: '#b3001b', logo: '■' },
  'US Bank': { start: '#0033a0', end: '#001f5c', logo: '★' },
  'Wells Fargo': { start: '#d71e28', end: '#a3161d', logo: '◇' },
  'Discover': { start: '#ff6600', end: '#cc5200', logo: '○' },
}

interface CreditCardVisualProps {
  card: CreditCard
  size?: 'sm' | 'md' | 'lg'
  className?: string
}

export function CreditCardVisual({ card, size = 'md', className }: CreditCardVisualProps) {
  const colors = ISSUER_COLORS[card.issuer] || { start: '#1a1a2e', end: '#16213e', logo: '●' }
  
  const sizeClasses = {
    sm: 'w-32 h-20 text-xs',
    md: 'w-48 h-30 text-sm',
    lg: 'w-64 h-40 text-base',
  }

  const aspectRatio = {
    sm: 'aspect-[1.6/1]',
    md: 'aspect-[1.6/1]',
    lg: 'aspect-[1.6/1]',
  }

  return (
    <div 
      className={cn(
        'rounded-xl shadow-lg overflow-hidden relative',
        sizeClasses[size],
        aspectRatio[size],
        className
      )}
      style={{
        background: `linear-gradient(135deg, ${card.card_color || colors.start} 0%, ${card.card_color_end || colors.end} 100%)`,
      }}
    >
      {/* Card chip */}
      <div className="absolute top-3 left-3">
        <div className="w-8 h-6 rounded bg-gradient-to-br from-yellow-300 to-yellow-500 opacity-80" />
      </div>
      
      {/* Issuer logo placeholder */}
      <div className="absolute top-3 right-3 text-white/80 text-2xl font-bold">
        {colors.logo}
      </div>
      
      {/* Card name */}
      <div className="absolute bottom-3 left-3 right-3">
        <p className="text-white/60 text-[10px] uppercase tracking-wider">
          {card.issuer}
        </p>
        <p className="text-white font-medium truncate text-xs leading-tight">
          {card.name.replace(card.issuer, '').trim()}
        </p>
      </div>

      {/* Decorative elements */}
      <div className="absolute top-0 right-0 w-32 h-32 bg-white/5 rounded-full -translate-y-1/2 translate-x-1/2" />
      <div className="absolute bottom-0 left-0 w-24 h-24 bg-white/5 rounded-full translate-y-1/2 -translate-x-1/2" />
    </div>
  )
}
