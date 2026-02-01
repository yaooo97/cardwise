'use client'

import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { CreditCard } from '@/types/database'
import { CreditCardVisual } from '@/components/cards/credit-card-visual'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { formatCurrency } from '@/lib/utils'
import { Search, Loader2, Wallet, CreditCard as CreditCardIcon, Check, X, ExternalLink } from 'lucide-react'
import Link from 'next/link'

const ISSUERS = ['All', 'Chase', 'Amex', 'Citi', 'Capital One', 'Bank of America', 'US Bank', 'Wells Fargo', 'Discover', 'Barclays']

type ViewMode = 'my-cards' | 'all-cards'

export default function MyCardsPage() {
  const [cards, setCards] = useState<CreditCard[]>([])
  const [userCards, setUserCards] = useState<Set<string>>(new Set())
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedIssuer, setSelectedIssuer] = useState('All')
  const [viewMode, setViewMode] = useState<ViewMode>('my-cards')
  
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

  const addCard = async (cardId: string) => {
    setSaving(true)
    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (user) {
        await supabase
          .from('user_cards')
          .insert({ user_id: user.id, card_id: cardId } as never)
        
        setUserCards(prev => new Set([...prev, cardId]))
      }
    } catch (error) {
      console.error('Error adding card:', error)
    } finally {
      setSaving(false)
    }
  }

  const removeCard = async (cardId: string) => {
    setSaving(true)
    try {
      await supabase
        .from('user_cards')
        .delete()
        .eq('card_id', cardId)
      
      setUserCards(prev => {
        const next = new Set(prev)
        next.delete(cardId)
        return next
      })
    } catch (error) {
      console.error('Error removing card:', error)
    } finally {
      setSaving(false)
    }
  }

  // Filter cards based on view mode and search
  const filteredCards = cards.filter(card => {
    const matchesSearch = card.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         card.issuer.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesIssuer = selectedIssuer === 'All' || card.issuer === selectedIssuer
    const matchesViewMode = viewMode === 'all-cards' || userCards.has(card.id)
    return matchesSearch && matchesIssuer && matchesViewMode
  })

  // Group cards by issuer
  const groupedCards = filteredCards.reduce((acc, card) => {
    if (!acc[card.issuer]) {
      acc[card.issuer] = []
    }
    acc[card.issuer].push(card)
    return acc
  }, {} as Record<string, CreditCard[]>)

  // Get user's cards for the wallet display
  const myCards = cards.filter(card => userCards.has(card.id))

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
          Manage your credit card collection and get personalized recommendations.
        </p>
      </div>

      {/* View Mode Toggle */}
      <div className="flex gap-2">
        <Button
          variant={viewMode === 'my-cards' ? 'default' : 'outline'}
          onClick={() => setViewMode('my-cards')}
          className="gap-2"
        >
          <Wallet className="h-4 w-4" />
          My Wallet ({userCards.size})
        </Button>
        <Button
          variant={viewMode === 'all-cards' ? 'default' : 'outline'}
          onClick={() => setViewMode('all-cards')}
          className="gap-2"
        >
          <CreditCardIcon className="h-4 w-4" />
          All Cards ({cards.length})
        </Button>
      </div>

      {/* My Wallet View */}
      {viewMode === 'my-cards' && (
        <>
          {myCards.length === 0 ? (
            <Card>
              <CardContent className="py-12 text-center">
                <Wallet className="h-12 w-12 text-gray-300 dark:text-gray-600 mx-auto mb-4" />
                <h3 className="text-lg font-medium text-gray-900 dark:text-white mb-2">
                  Your wallet is empty
                </h3>
                <p className="text-gray-500 dark:text-gray-400 mb-4">
                  Switch to &quot;All Cards&quot; to add cards to your wallet.
                </p>
                <Button onClick={() => setViewMode('all-cards')}>
                  Browse All Cards
                </Button>
              </CardContent>
            </Card>
          ) : (
            <>
              {/* Card Gallery - Visual Display */}
              <Card>
                <CardHeader>
                  <CardTitle>My Wallet</CardTitle>
                  <CardDescription>Click a card to view details, or hover to remove</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="flex flex-wrap gap-4">
                    {myCards.map(card => (
                      <div key={card.id} className="relative group">
                        <Link href={`/dashboard/cards/${card.id}`}>
                          <div className="transition-transform group-hover:scale-105 group-hover:-translate-y-1">
                            <CreditCardVisual card={card} size="md" />
                          </div>
                        </Link>
                        <p className="mt-2 text-sm font-medium text-gray-900 dark:text-white text-center truncate max-w-[192px]">
                          {card.name}
                        </p>
                        {/* Remove button on hover */}
                        <button
                          onClick={() => removeCard(card.id)}
                          className="absolute -top-2 -right-2 opacity-0 group-hover:opacity-100 transition-opacity bg-red-500 hover:bg-red-600 text-white rounded-full p-1.5 shadow-lg z-10"
                          title="Remove from wallet"
                        >
                          <X className="h-4 w-4" />
                        </button>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>

              {/* Detailed List */}
              <div className="space-y-4">
                <h2 className="text-lg font-semibold text-gray-900 dark:text-white">
                  Card Details
                </h2>
                <div className="grid grid-cols-1 gap-4">
                  {myCards.map(card => (
                    <Card key={card.id} className="hover:shadow-md transition-shadow">
                      <CardContent className="p-4">
                        <div className="flex items-center gap-4">
                          <CreditCardVisual card={card} size="sm" className="shrink-0" />
                          
                          <div className="flex-1 min-w-0">
                            <h3 className="font-medium text-gray-900 dark:text-white">
                              {card.name}
                            </h3>
                            <p className="text-sm text-gray-500 dark:text-gray-400">{card.issuer}</p>
                            <div className="flex flex-wrap gap-2 mt-2">
                              <Badge variant="secondary">
                                {card.annual_fee === 0 ? 'No AF' : `${formatCurrency(card.annual_fee)} AF`}
                              </Badge>
                              {card.point_type && (
                                <Badge variant="outline">{card.point_type}</Badge>
                              )}
                              {card.current_sub > 0 && (
                                <Badge variant="success">
                                  SUB: {formatCurrency(card.current_sub)}
                                </Badge>
                              )}
                            </div>
                          </div>

                          <div className="flex gap-2 shrink-0">
                            <Link href={`/dashboard/cards/${card.id}`}>
                              <Button variant="outline" size="sm">
                                Details
                                <ExternalLink className="ml-1 h-3 w-3" />
                              </Button>
                            </Link>
                            <Button 
                              variant="outline" 
                              size="sm"
                              onClick={() => removeCard(card.id)}
                              className="text-red-600 hover:text-red-700 hover:bg-red-50"
                            >
                              <X className="h-4 w-4" />
                            </Button>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              </div>
            </>
          )}
        </>
      )}

      {/* All Cards View */}
      {viewMode === 'all-cards' && (
        <>
          {/* Filters */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">Browse & Add Cards</CardTitle>
              <CardDescription>Click the + button to add a card to your wallet</CardDescription>
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
                <div className="text-2xl font-bold text-gray-900 dark:text-white">{filteredCards.length}</div>
                <p className="text-sm text-gray-500 dark:text-gray-400">Cards shown</p>
              </CardContent>
            </Card>
          </div>

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
                  {issuerCards.map(card => {
                    const isOwned = userCards.has(card.id)
                    return (
                      <Card 
                        key={card.id}
                        className={`hover:shadow-md transition-shadow ${isOwned ? 'ring-2 ring-primary bg-primary/5' : ''}`}
                      >
                        <CardContent className="p-4">
                          <div className="flex items-center gap-4">
                            <CreditCardVisual card={card} size="sm" className="shrink-0" />
                            
                            <div className="flex-1 min-w-0">
                              <div className="flex items-center gap-2">
                                <h3 className="font-medium text-gray-900 dark:text-white truncate">
                                  {card.name}
                                </h3>
                                {isOwned && (
                                  <Check className="h-4 w-4 text-primary shrink-0" />
                                )}
                              </div>
                              <p className="text-sm text-gray-500 dark:text-gray-400">{card.issuer}</p>
                              <div className="flex flex-wrap gap-1 mt-1">
                                <Badge variant="secondary" className="text-xs">
                                  {card.annual_fee === 0 ? 'No AF' : `${formatCurrency(card.annual_fee)}`}
                                </Badge>
                                {card.is_at_highest && (
                                  <Badge variant="success" className="text-xs">ATH SUB</Badge>
                                )}
                              </div>
                            </div>

                            <div className="flex flex-col gap-2 shrink-0">
                              {isOwned ? (
                                <Button 
                                  variant="outline" 
                                  size="sm"
                                  onClick={() => removeCard(card.id)}
                                  className="text-red-600 hover:text-red-700 hover:bg-red-50"
                                >
                                  <X className="h-4 w-4 mr-1" />
                                  Remove
                                </Button>
                              ) : (
                                <Button 
                                  variant="default" 
                                  size="sm"
                                  onClick={() => addCard(card.id)}
                                >
                                  <Check className="h-4 w-4 mr-1" />
                                  Add
                                </Button>
                              )}
                              <Link href={`/dashboard/cards/${card.id}`}>
                                <Button variant="ghost" size="sm" className="w-full text-xs">
                                  Details →
                                </Button>
                              </Link>
                            </div>
                          </div>
                        </CardContent>
                      </Card>
                    )
                  })}
                </div>
              </div>
            ))
          )}
        </>
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
