'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { CreditCard } from '@/types/database'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { formatCurrency } from '@/lib/utils'
import { Search, TrendingUp, ExternalLink, Loader2, CreditCard as CreditCardIcon, Check, Star } from 'lucide-react'

const ISSUERS = ['All', 'Chase', 'Amex', 'Citi', 'Capital One', 'Bank of America', 'US Bank']

export default function OpenCardPage() {
  const [cards, setCards] = useState<CreditCard[]>([])
  const [userCardIds, setUserCardIds] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedIssuer, setSelectedIssuer] = useState('All')
  const [showHighestOnly, setShowHighestOnly] = useState(false)
  const [hideOwned, setHideOwned] = useState(false)
  
  const supabase = createClient()

  useEffect(() => {
    fetchData()
  }, [])

  const fetchData = async () => {
    setLoading(true)
    try {
      // Fetch all cards ordered by SUB value
      const { data: cardsData } = await supabase
        .from('credit_cards')
        .select('*')
        .order('current_sub', { ascending: false })

      if (cardsData) {
        setCards(cardsData)
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

  const filteredCards = cards.filter(card => {
    const matchesSearch = card.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         card.issuer.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesIssuer = selectedIssuer === 'All' || card.issuer === selectedIssuer
    const matchesHighest = !showHighestOnly || card.is_at_highest
    const matchesOwned = !hideOwned || !userCardIds.has(card.id)
    return matchesSearch && matchesIssuer && matchesHighest && matchesOwned
  })

  const highestSubCards = cards.filter(c => c.is_at_highest)

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
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Open a Card</h1>
        <p className="text-gray-600 dark:text-gray-400 mt-1">
          Find the best credit cards to apply for based on sign-up bonuses.
        </p>
      </div>

      {/* Highlight cards at all-time high */}
      {highestSubCards.length > 0 && (
        <Card className="bg-gradient-to-r from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 border-green-200 dark:border-green-800">
          <CardHeader>
            <div className="flex items-center gap-2">
              <Star className="h-5 w-5 text-green-600" />
              <CardTitle className="text-green-800 dark:text-green-300">
                All-Time High Bonuses
              </CardTitle>
            </div>
            <CardDescription className="text-green-700 dark:text-green-400">
              {highestSubCards.length} card{highestSubCards.length > 1 ? 's are' : ' is'} currently at their highest sign-up bonus ever!
            </CardDescription>
          </CardHeader>
        </Card>
      )}

      {/* Filters */}
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Filters</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-gray-400" />
            <Input
              placeholder="Search cards..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-10"
            />
          </div>
          
          <div className="flex flex-wrap gap-2">
            {ISSUERS.map(issuer => (
              <Button
                key={issuer}
                variant={selectedIssuer === issuer ? 'default' : 'outline'}
                size="sm"
                onClick={() => setSelectedIssuer(issuer)}
              >
                {issuer}
              </Button>
            ))}
          </div>

          <div className="flex flex-wrap gap-4">
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={showHighestOnly}
                onChange={(e) => setShowHighestOnly(e.target.checked)}
                className="rounded border-gray-300"
              />
              <span className="text-sm">Show all-time high only</span>
            </label>
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={hideOwned}
                onChange={(e) => setHideOwned(e.target.checked)}
                className="rounded border-gray-300"
              />
              <span className="text-sm">Hide cards I own</span>
            </label>
          </div>
        </CardContent>
      </Card>

      {/* Cards List */}
      {filteredCards.length === 0 ? (
        <Card>
          <CardContent className="py-12 text-center">
            <p className="text-gray-500 dark:text-gray-400">
              No cards found. Try adjusting your filters.
            </p>
          </CardContent>
        </Card>
      ) : (
        <div className="space-y-4">
          {filteredCards.map((card, index) => (
            <Card 
              key={card.id}
              className={card.is_at_highest ? 'ring-2 ring-green-500 dark:ring-green-400' : ''}
            >
              <CardContent className="p-6">
                <div className="flex flex-col md:flex-row md:items-center gap-4">
                  {/* Rank */}
                  <div className="flex items-center justify-center w-10 h-10 rounded-full bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-300 font-bold shrink-0">
                    #{index + 1}
                  </div>

                  {/* Card image placeholder */}
                  <div className="w-20 h-12 rounded bg-gradient-to-br from-gray-700 to-gray-900 flex items-center justify-center shrink-0">
                    <CreditCardIcon className="h-6 w-6 text-white/70" />
                  </div>

                  {/* Card info */}
                  <div className="flex-1">
                    <div className="flex items-start gap-2 flex-wrap">
                      <h3 className="font-semibold text-gray-900 dark:text-white">
                        {card.name}
                      </h3>
                      {userCardIds.has(card.id) && (
                        <Badge variant="secondary" className="gap-1">
                          <Check className="h-3 w-3" />
                          Owned
                        </Badge>
                      )}
                      {card.is_at_highest && (
                        <Badge variant="success">All-Time High</Badge>
                      )}
                    </div>
                    <p className="text-sm text-gray-500 dark:text-gray-400">{card.issuer}</p>
                    
                    <div className="mt-2 flex flex-wrap gap-2">
                      <Badge variant="outline">
                        {card.annual_fee === 0 ? 'No Annual Fee' : `${formatCurrency(card.annual_fee)} Annual Fee`}
                      </Badge>
                      {card.point_type && (
                        <Badge variant="outline">{card.point_type}</Badge>
                      )}
                    </div>

                    {card.sub_requirements && (
                      <p className="mt-2 text-sm text-gray-600 dark:text-gray-400">
                        <span className="font-medium">Requirement:</span> {card.sub_requirements}
                      </p>
                    )}
                  </div>

                  {/* SUB Value */}
                  <div className="text-right shrink-0">
                    <div className="text-2xl font-bold text-green-600 dark:text-green-400">
                      {formatCurrency(card.current_sub)}
                    </div>
                    <p className="text-sm text-gray-500 dark:text-gray-400">Sign-up Bonus</p>
                    {card.highest_sub > card.current_sub && (
                      <p className="text-xs text-gray-400 mt-1">
                        Highest: {formatCurrency(card.highest_sub)}
                      </p>
                    )}
                  </div>

                  {/* Apply button */}
                  {card.apply_url && (
                    <a 
                      href={card.apply_url} 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="shrink-0 inline-flex items-center justify-center rounded-md text-sm font-medium h-10 px-4 py-2 bg-primary text-primary-foreground hover:bg-primary/90 transition-colors"
                    >
                      Apply
                      <ExternalLink className="ml-2 h-4 w-4" />
                    </a>
                  )}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  )
}
