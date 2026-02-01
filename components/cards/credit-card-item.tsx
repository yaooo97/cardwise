'use client'

import { CreditCard } from '@/types/database'
import { Badge } from '@/components/ui/badge'
import { Card, CardContent } from '@/components/ui/card'
import { formatCurrency } from '@/lib/utils'
import { Check } from 'lucide-react'
import { cn } from '@/lib/utils'
import { CreditCardVisual } from './credit-card-visual'
import Link from 'next/link'

interface CreditCardItemProps {
  card: CreditCard
  isOwned?: boolean
  onToggle?: (cardId: string, e: React.MouseEvent) => void
  showRewards?: boolean
  clickable?: boolean
}

export function CreditCardItem({ card, isOwned = false, onToggle, showRewards = false, clickable = true }: CreditCardItemProps) {
  const content = (
    <Card 
      className={cn(
        'transition-all hover:shadow-md',
        isOwned && 'ring-2 ring-primary bg-primary/5',
        clickable && 'cursor-pointer',
        onToggle && 'cursor-pointer'
      )}
      onClick={(e) => onToggle?.(card.id, e)}
    >
      <CardContent className="p-4">
        <div className="flex items-start gap-4">
          {/* Card visual */}
          <CreditCardVisual card={card} size="sm" className="shrink-0" />

          <div className="flex-1 min-w-0">
            <div className="flex items-start justify-between gap-2">
              <div>
                <h3 className="font-medium text-gray-900 dark:text-white truncate">
                  {card.name}
                </h3>
                <p className="text-sm text-gray-500 dark:text-gray-400">
                  {card.issuer}
                </p>
              </div>
              
              {isOwned && (
                <div className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-primary text-primary-foreground">
                  <Check className="h-4 w-4" />
                </div>
              )}
            </div>

            <div className="mt-2 flex flex-wrap gap-2">
              <Badge variant="secondary">
                {card.annual_fee === 0 ? 'No AF' : `${formatCurrency(card.annual_fee)} AF`}
              </Badge>
              {card.is_at_highest && (
                <Badge variant="success">All-Time High</Badge>
              )}
              {card.point_type && (
                <Badge variant="outline">{card.point_type}</Badge>
              )}
            </div>

            {showRewards && card.current_sub > 0 && (
              <div className="mt-2">
                <p className="text-sm">
                  <span className="text-gray-500 dark:text-gray-400">Current SUB: </span>
                  <span className="font-semibold text-green-600 dark:text-green-400">
                    {formatCurrency(card.current_sub)}
                  </span>
                </p>
              </div>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  )

  if (clickable && !onToggle) {
    return (
      <Link href={`/dashboard/cards/${card.id}`}>
        {content}
      </Link>
    )
  }

  return content
}
