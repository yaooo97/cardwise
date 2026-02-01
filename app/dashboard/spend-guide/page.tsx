'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { CreditCard, CardReward, SpendingCategory } from '@/types/database'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { formatCurrency } from '@/lib/utils'
import { 
  Loader2, 
  CreditCard as CreditCardIcon, 
  Utensils, 
  ShoppingCart, 
  Fuel, 
  Plane, 
  Home, 
  Tv, 
  ShoppingBag,
  Car,
  Briefcase,
  MoreHorizontal,
  Trophy
} from 'lucide-react'

// Default categories with icons
const DEFAULT_CATEGORIES = [
  { name: 'dining', display_name: 'Dining', icon: 'Utensils' },
  { name: 'grocery', display_name: 'Grocery', icon: 'ShoppingCart' },
  { name: 'gas', display_name: 'Gas', icon: 'Fuel' },
  { name: 'travel', display_name: 'Travel', icon: 'Plane' },
  { name: 'streaming', display_name: 'Streaming', icon: 'Tv' },
  { name: 'online_shopping', display_name: 'Online Shopping', icon: 'ShoppingBag' },
  { name: 'rent', display_name: 'Rent/Mortgage', icon: 'Home' },
  { name: 'transit', display_name: 'Transit', icon: 'Car' },
  { name: 'business', display_name: 'Business', icon: 'Briefcase' },
  { name: 'other', display_name: 'Everything Else', icon: 'MoreHorizontal' },
]

const ICON_MAP: Record<string, React.ComponentType<{ className?: string }>> = {
  Utensils,
  ShoppingCart,
  Fuel,
  Plane,
  Home,
  Tv,
  ShoppingBag,
  Car,
  Briefcase,
  MoreHorizontal,
}

type CardWithReward = CreditCard & { reward?: CardReward }

export default function SpendGuidePage() {
  const [cards, setCards] = useState<CreditCard[]>([])
  const [rewards, setRewards] = useState<CardReward[]>([])
  const [userCardIds, setUserCardIds] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(true)
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)
  const [showAllCards, setShowAllCards] = useState(false)
  
  const supabase = createClient()

  useEffect(() => {
    fetchData()
  }, [])

  const fetchData = async () => {
    setLoading(true)
    try {
      // Fetch all cards
      const { data: cardsData } = await supabase
        .from('credit_cards')
        .select('*')

      if (cardsData) {
        setCards(cardsData)
      }

      // Fetch all rewards
      const { data: rewardsData } = await supabase
        .from('card_rewards')
        .select('*')

      if (rewardsData) {
        setRewards(rewardsData)
      }

      // Fetch user's cards
      const { data: userCardsData } = await supabase
        .from('user_cards')
        .select('card_id')

      if (userCardsData) {
        setUserCardIds(new Set((userCardsData as { card_id: string }[]).map(uc => uc.card_id)))
      }
    } catch (error) {
      console.error('Error fetching data:', error)
    } finally {
      setLoading(false)
    }
  }

  // Get best cards for a category
  const getBestCardsForCategory = (categoryName: string): CardWithReward[] => {
    const categoryRewards = rewards.filter(r => r.category === categoryName)
    
    const cardsToShow = showAllCards ? cards : cards.filter(c => userCardIds.has(c.id))
    
    const cardsWithRewards: CardWithReward[] = cardsToShow.map(card => {
      const reward = categoryRewards.find(r => r.card_id === card.id)
      return { ...card, reward }
    })

    // Sort by reward rate (highest first), cards without rewards go to end
    return cardsWithRewards.sort((a, b) => {
      if (!a.reward && !b.reward) return 0
      if (!a.reward) return 1
      if (!b.reward) return -1
      return b.reward.reward_rate - a.reward.reward_rate
    })
  }

  const formatRewardRate = (reward: CardReward) => {
    if (reward.reward_unit === 'percent') {
      return `${reward.reward_rate}% back`
    }
    return `${reward.reward_rate}x points`
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[400px]">
        <Loader2 className="h-8 w-8 animate-spin text-primary" />
      </div>
    )
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Spending Guide</h1>
        <p className="text-gray-600 dark:text-gray-400 mt-1">
          Find the best card to use for each spending category.
        </p>
      </div>

      {/* Toggle for showing all cards vs user cards */}
      <Card>
        <CardContent className="py-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="font-medium text-gray-900 dark:text-white">Card Selection</p>
              <p className="text-sm text-gray-500 dark:text-gray-400">
                {showAllCards ? 'Showing all cards' : `Showing your ${userCardIds.size} cards`}
              </p>
            </div>
            <Button
              variant={showAllCards ? 'default' : 'outline'}
              onClick={() => setShowAllCards(!showAllCards)}
            >
              {showAllCards ? 'Show My Cards Only' : 'Show All Cards'}
            </Button>
          </div>
        </CardContent>
      </Card>

      {userCardIds.size === 0 && !showAllCards && (
        <Card className="bg-yellow-50 dark:bg-yellow-900/20 border-yellow-200 dark:border-yellow-800">
          <CardContent className="py-6 text-center">
            <p className="text-yellow-800 dark:text-yellow-200">
              You haven&apos;t added any cards yet. Add your cards in &quot;My Cards&quot; or toggle &quot;Show All Cards&quot; to see recommendations.
            </p>
          </CardContent>
        </Card>
      )}

      {/* Category Selection */}
      <div>
        <h2 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
          Select a Spending Category
        </h2>
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-3">
          {DEFAULT_CATEGORIES.map(category => {
            const Icon = ICON_MAP[category.icon] || MoreHorizontal
            const isSelected = selectedCategory === category.name
            
            return (
              <button
                key={category.name}
                onClick={() => setSelectedCategory(isSelected ? null : category.name)}
                className={`p-4 rounded-xl border-2 transition-all ${
                  isSelected
                    ? 'border-primary bg-primary/10 dark:bg-primary/20'
                    : 'border-gray-200 dark:border-gray-700 hover:border-primary/50'
                }`}
              >
                <Icon className={`h-6 w-6 mx-auto mb-2 ${isSelected ? 'text-primary' : 'text-gray-500'}`} />
                <p className={`text-sm font-medium ${isSelected ? 'text-primary' : 'text-gray-700 dark:text-gray-300'}`}>
                  {category.display_name}
                </p>
              </button>
            )
          })}
        </div>
      </div>

      {/* Results */}
      {selectedCategory && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Trophy className="h-5 w-5 text-yellow-500" />
              Best Cards for {DEFAULT_CATEGORIES.find(c => c.name === selectedCategory)?.display_name}
            </CardTitle>
            <CardDescription>
              {showAllCards ? 'All available cards' : 'Based on your card collection'}
            </CardDescription>
          </CardHeader>
          <CardContent>
            {(() => {
              const rankedCards = getBestCardsForCategory(selectedCategory)
              const cardsWithRewards = rankedCards.filter(c => c.reward)
              const cardsWithoutRewards = rankedCards.filter(c => !c.reward)

              if (rankedCards.length === 0) {
                return (
                  <p className="text-center text-gray-500 dark:text-gray-400 py-8">
                    No cards available. {!showAllCards && 'Try adding cards to your collection.'}
                  </p>
                )
              }

              return (
                <div className="space-y-4">
                  {/* Cards with rewards for this category */}
                  {cardsWithRewards.map((card, index) => (
                    <div 
                      key={card.id}
                      className={`flex items-center gap-4 p-4 rounded-lg ${
                        index === 0 
                          ? 'bg-gradient-to-r from-yellow-50 to-amber-50 dark:from-yellow-900/20 dark:to-amber-900/20 border border-yellow-200 dark:border-yellow-800'
                          : 'bg-gray-50 dark:bg-gray-800'
                      }`}
                    >
                      {/* Rank */}
                      <div className={`flex items-center justify-center w-8 h-8 rounded-full font-bold text-sm shrink-0 ${
                        index === 0 
                          ? 'bg-yellow-500 text-white' 
                          : 'bg-gray-200 dark:bg-gray-700 text-gray-600 dark:text-gray-300'
                      }`}>
                        {index + 1}
                      </div>

                      {/* Card icon */}
                      <div className="w-12 h-8 rounded bg-gradient-to-br from-gray-700 to-gray-900 flex items-center justify-center shrink-0">
                        <CreditCardIcon className="h-4 w-4 text-white/70" />
                      </div>

                      {/* Card info */}
                      <div className="flex-1 min-w-0">
                        <p className="font-medium text-gray-900 dark:text-white truncate">
                          {card.name}
                        </p>
                        <p className="text-sm text-gray-500 dark:text-gray-400">
                          {card.issuer}
                        </p>
                      </div>

                      {/* Reward rate */}
                      <div className="text-right shrink-0">
                        <p className={`font-bold ${index === 0 ? 'text-yellow-600 dark:text-yellow-400 text-lg' : 'text-green-600 dark:text-green-400'}`}>
                          {card.reward && formatRewardRate(card.reward)}
                        </p>
                        {card.reward?.cap_amount && (
                          <p className="text-xs text-gray-500">
                            Up to {formatCurrency(card.reward.cap_amount)}
                          </p>
                        )}
                      </div>
                    </div>
                  ))}

                  {/* Cards without specific rewards */}
                  {cardsWithoutRewards.length > 0 && cardsWithRewards.length > 0 && (
                    <div className="pt-4 border-t border-gray-200 dark:border-gray-700">
                      <p className="text-sm text-gray-500 dark:text-gray-400 mb-3">
                        Other cards (base rewards or no bonus in this category)
                      </p>
                      <div className="space-y-2">
                        {cardsWithoutRewards.slice(0, 3).map(card => (
                          <div key={card.id} className="flex items-center gap-3 text-sm text-gray-600 dark:text-gray-400">
                            <CreditCardIcon className="h-4 w-4" />
                            <span>{card.name}</span>
                            <span className="text-gray-400">({card.issuer})</span>
                          </div>
                        ))}
                        {cardsWithoutRewards.length > 3 && (
                          <p className="text-sm text-gray-400">
                            +{cardsWithoutRewards.length - 3} more cards
                          </p>
                        )}
                      </div>
                    </div>
                  )}

                  {cardsWithRewards.length === 0 && (
                    <p className="text-center text-gray-500 dark:text-gray-400 py-4">
                      No cards have bonus rewards for this category. Use your card with the best base rate.
                    </p>
                  )}
                </div>
              )
            })()}
          </CardContent>
        </Card>
      )}

      {!selectedCategory && (
        <Card>
          <CardContent className="py-12 text-center">
            <ShoppingBag className="h-12 w-12 text-gray-300 dark:text-gray-600 mx-auto mb-4" />
            <p className="text-gray-500 dark:text-gray-400">
              Select a spending category above to see which card to use.
            </p>
          </CardContent>
        </Card>
      )}
    </div>
  )
}
