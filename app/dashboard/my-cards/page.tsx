'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { CreditCard, UserCard } from '@/types/database'
import { CreditCardItem } from '@/components/cards/credit-card-item'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Search, Filter, Loader2 } from 'lucide-react'

const ISSUERS = ['All', 'Chase', 'Amex', 'Citi', 'Capital One', 'Bank of America', 'US Bank', 'Wells Fargo', 'Discover']

export default function MyCardsPage() {
  const [cards, setCards] = useState<CreditCard[]>([])
  const [userCards, setUserCards] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedIssuer, setSelectedIssuer] = useState('All')
  
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
        .order('issuer', { ascending: true })
        .order('name', { ascending: true })

      if (cardsData) {
        setCards(cardsData)
      }

      // Fetch user's cards
      const { data: userCardsData } = await supabase
        .from('user_cards')
        .select('card_id')

      if (userCardsData) {
        setUserCards(new Set((userCardsData as { card_id: string }[]).map(uc => uc.card_id)))
      }
    } catch (error) {
      console.error('Error fetching data:', error)
    } finally {
      setLoading(false)
    }
  }

  const toggleCard = async (cardId: string) => {
    setSaving(true)
    const isOwned = userCards.has(cardId)
    
    try {
      if (isOwned) {
        // Remove card
        await supabase
          .from('user_cards')
          .delete()
          .eq('card_id', cardId)
        
        setUserCards(prev => {
          const next = new Set(prev)
          next.delete(cardId)
          return next
        })
      } else {
        // Add card
        const { data: { user } } = await supabase.auth.getUser()
        if (user) {
          await supabase
            .from('user_cards')
            .insert({ user_id: user.id, card_id: cardId } as never)
          
          setUserCards(prev => new Set([...prev, cardId]))
        }
      }
    } catch (error) {
      console.error('Error toggling card:', error)
    } finally {
      setSaving(false)
    }
  }

  const filteredCards = cards.filter(card => {
    const matchesSearch = card.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         card.issuer.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesIssuer = selectedIssuer === 'All' || card.issuer === selectedIssuer
    return matchesSearch && matchesIssuer
  })

  // Group cards by issuer
  const groupedCards = filteredCards.reduce((acc, card) => {
    if (!acc[card.issuer]) {
      acc[card.issuer] = []
    }
    acc[card.issuer].push(card)
    return acc
  }, {} as Record<string, CreditCard[]>)

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
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">My Cards</h1>
        <p className="text-gray-600 dark:text-gray-400 mt-1">
          Select the credit cards you own to get personalized recommendations.
        </p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 gap-4">
        <Card>
          <CardContent className="pt-6">
            <div className="text-2xl font-bold text-primary">{userCards.size}</div>
            <p className="text-sm text-gray-500 dark:text-gray-400">Cards in your wallet</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="pt-6">
            <div className="text-2xl font-bold text-gray-900 dark:text-white">{cards.length}</div>
            <p className="text-sm text-gray-500 dark:text-gray-400">Total cards available</p>
          </CardContent>
        </Card>
      </div>

      {/* Filters */}
      <Card>
        <CardHeader>
          <CardTitle className="text-lg">Filter Cards</CardTitle>
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
        </CardContent>
      </Card>

      {/* Cards List */}
      {Object.keys(groupedCards).length === 0 ? (
        <Card>
          <CardContent className="py-12 text-center">
            <p className="text-gray-500 dark:text-gray-400">
              No cards found. Try adjusting your filters.
            </p>
          </CardContent>
        </Card>
      ) : (
        Object.entries(groupedCards).map(([issuer, issuerCards]) => (
          <div key={issuer} className="space-y-3">
            <h2 className="text-lg font-semibold text-gray-900 dark:text-white flex items-center gap-2">
              {issuer}
              <span className="text-sm font-normal text-gray-500">({issuerCards.length})</span>
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {issuerCards.map(card => (
                <CreditCardItem
                  key={card.id}
                  card={card}
                  isOwned={userCards.has(card.id)}
                  onToggle={toggleCard}
                />
              ))}
            </div>
          </div>
        ))
      )}

      {saving && (
        <div className="fixed bottom-4 right-4 bg-primary text-primary-foreground px-4 py-2 rounded-lg shadow-lg flex items-center gap-2">
          <Loader2 className="h-4 w-4 animate-spin" />
          Saving...
        </div>
      )}
    </div>
  )
}
