'use client'

import { useState, useEffect, use } from 'react'
import { createClient } from '@/lib/supabase/client'
import { CreditCard, CardReward } from '@/types/database'
import { CreditCardVisual } from '@/components/cards/credit-card-visual'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatCurrency } from '@/lib/utils'
import { 
  ArrowLeft, 
  ExternalLink, 
  Calendar, 
  DollarSign, 
  Star, 
  Plane,
  Clock,
  TrendingUp,
  Check,
  Plus
} from 'lucide-react'
import Link from 'next/link'

export default function CardDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params)
  const [card, setCard] = useState<CreditCard | null>(null)
  const [rewards, setRewards] = useState<CardReward[]>([])
  const [isOwned, setIsOwned] = useState(false)
  const [loading, setLoading] = useState(true)
  
  const supabase = createClient()

  useEffect(() => {
    fetchData()
  }, [id])

  const fetchData = async () => {
    setLoading(true)
    try {
      // Fetch card details
      const { data: cardData } = await supabase
        .from('credit_cards')
        .select('*')
        .eq('id', id)
        .single()

      if (cardData) {
        setCard(cardData)
      }

      // Fetch card rewards
      const { data: rewardsData } = await supabase
        .from('card_rewards')
        .select('*')
        .eq('card_id', id)

      if (rewardsData) {
        setRewards(rewardsData)
      }

      // Check if user owns this card
      const { data: userCardData } = await supabase
        .from('user_cards')
        .select('id')
        .eq('card_id', id)
        .maybeSingle()

      setIsOwned(!!userCardData)
    } catch (error) {
      console.error('Error fetching card:', error)
    } finally {
      setLoading(false)
    }
  }

  const toggleOwnership = async () => {
    if (!card) return
    
    try {
      if (isOwned) {
        await supabase
          .from('user_cards')
          .delete()
          .eq('card_id', card.id)
        setIsOwned(false)
      } else {
        const { data: { user } } = await supabase.auth.getUser()
        if (user) {
          await supabase
            .from('user_cards')
            .insert({ user_id: user.id, card_id: card.id } as never)
          setIsOwned(true)
        }
      }
    } catch (error) {
      console.error('Error toggling ownership:', error)
    }
  }

  const formatRewardRate = (reward: CardReward) => {
    if (reward.reward_unit === 'percent') {
      return `${reward.reward_rate}%`
    }
    return `${reward.reward_rate}x`
  }

  const getCategoryDisplayName = (category: string) => {
    const names: Record<string, string> = {
      dining: 'Dining',
      grocery: 'Grocery',
      gas: 'Gas',
      travel: 'Travel',
      streaming: 'Streaming',
      online_shopping: 'Online Shopping',
      transit: 'Transit',
      business: 'Business',
      other: 'Everything Else',
    }
    return names[category] || category
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" />
      </div>
    )
  }

  if (!card) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">Card not found</p>
        <Link href="/dashboard/my-cards">
          <Button variant="outline" className="mt-4">
            <ArrowLeft className="mr-2 h-4 w-4" />
            Back to My Cards
          </Button>
        </Link>
      </div>
    )
  }

  const daysUntilEnd = card.sub_end_date 
    ? Math.ceil((new Date(card.sub_end_date).getTime() - Date.now()) / (1000 * 60 * 60 * 24))
    : null

  return (
    <div className="space-y-6 max-w-4xl mx-auto">
      {/* Back button */}
      <Link href="/dashboard/my-cards" className="inline-flex items-center text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
        <ArrowLeft className="mr-2 h-4 w-4" />
        Back to Cards
      </Link>

      {/* Header with card visual */}
      <div className="flex flex-col md:flex-row gap-6 items-start">
        <CreditCardVisual card={card} size="lg" className="shrink-0" />
        
        <div className="flex-1">
          <div className="flex items-start justify-between gap-4">
            <div>
              <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
                {card.name}
              </h1>
              <p className="text-gray-500 dark:text-gray-400">{card.issuer}</p>
            </div>
            
            <Button
              variant={isOwned ? 'outline' : 'default'}
              onClick={toggleOwnership}
            >
              {isOwned ? (
                <>
                  <Check className="mr-2 h-4 w-4" />
                  In My Wallet
                </>
              ) : (
                <>
                  <Plus className="mr-2 h-4 w-4" />
                  Add to Wallet
                </>
              )}
            </Button>
          </div>

          <div className="flex flex-wrap gap-2 mt-4">
            <Badge variant="secondary">
              {card.annual_fee === 0 ? 'No Annual Fee' : `${formatCurrency(card.annual_fee)} Annual Fee`}
            </Badge>
            {card.point_type && (
              <Badge variant="outline">{card.point_type}</Badge>
            )}
            {card.is_at_highest && (
              <Badge variant="success">All-Time High SUB</Badge>
            )}
          </div>

          {card.description && (
            <p className="mt-4 text-gray-600 dark:text-gray-400">
              {card.description}
            </p>
          )}
        </div>
      </div>

      {/* Sign-up Bonus Section */}
      <Card className={card.is_at_highest ? 'border-green-500 dark:border-green-400' : ''}>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <TrendingUp className="h-5 w-5 text-green-500" />
            Sign-Up Bonus
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">Current Bonus</p>
              <p className="text-3xl font-bold text-green-600 dark:text-green-400">
                {formatCurrency(card.current_sub)}
              </p>
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">All-Time High</p>
              <p className="text-2xl font-semibold text-gray-900 dark:text-white">
                {formatCurrency(card.highest_sub)}
              </p>
              {card.is_at_highest && (
                <Badge variant="success" className="mt-1">Currently at highest!</Badge>
              )}
            </div>
            <div>
              <p className="text-sm text-gray-500 dark:text-gray-400">Requirement</p>
              <p className="text-lg font-medium text-gray-900 dark:text-white">
                {card.sub_requirements || 'N/A'}
              </p>
            </div>
          </div>

          {daysUntilEnd !== null && (
            <div className={`mt-4 p-3 rounded-lg flex items-center gap-2 ${
              daysUntilEnd <= 7 
                ? 'bg-red-50 dark:bg-red-900/20 text-red-700 dark:text-red-400'
                : daysUntilEnd <= 30
                ? 'bg-yellow-50 dark:bg-yellow-900/20 text-yellow-700 dark:text-yellow-400'
                : 'bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-400'
            }`}>
              <Clock className="h-5 w-5" />
              <span className="font-medium">
                {daysUntilEnd > 0 
                  ? `Offer ends in ${daysUntilEnd} days (${card.sub_end_date})`
                  : 'Offer has expired'}
              </span>
            </div>
          )}

          {card.apply_url && (
            <a
              href={card.apply_url}
              target="_blank"
              rel="noopener noreferrer"
              className="mt-4 inline-flex items-center justify-center rounded-md text-sm font-medium h-10 px-4 py-2 bg-primary text-primary-foreground hover:bg-primary/90 transition-colors"
            >
              Apply Now
              <ExternalLink className="ml-2 h-4 w-4" />
            </a>
          )}
        </CardContent>
      </Card>

      {/* Rewards Section */}
      {rewards.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Star className="h-5 w-5 text-yellow-500" />
              Reward Rates
            </CardTitle>
            <CardDescription>Earn rates by spending category</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {rewards.map(reward => (
                <div 
                  key={reward.id}
                  className="flex items-center justify-between p-3 rounded-lg bg-gray-50 dark:bg-gray-800"
                >
                  <div>
                    <p className="font-medium text-gray-900 dark:text-white">
                      {getCategoryDisplayName(reward.category)}
                    </p>
                    {reward.notes && (
                      <p className="text-xs text-gray-500 dark:text-gray-400">
                        {reward.notes}
                      </p>
                    )}
                  </div>
                  <div className="text-right">
                    <p className="text-xl font-bold text-primary">
                      {formatRewardRate(reward)}
                    </p>
                    {reward.cap_amount && (
                      <p className="text-xs text-gray-500">
                        Up to {formatCurrency(reward.cap_amount)}
                      </p>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Transfer Partners */}
      {card.transfer_partners && card.transfer_partners.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Plane className="h-5 w-5 text-blue-500" />
              Transfer Partners
            </CardTitle>
            <CardDescription>Airlines and hotels you can transfer points to</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="flex flex-wrap gap-2">
              {card.transfer_partners.map(partner => (
                <Badge key={partner} variant="secondary" className="text-sm">
                  {partner}
                </Badge>
              ))}
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  )
}
