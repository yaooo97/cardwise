import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { CreditCard, TrendingUp, ShoppingBag, ArrowRight } from 'lucide-react'
import Link from 'next/link'

export default function DashboardPage() {
  return (
    <div className="space-y-8">
      <div>
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Dashboard</h1>
        <p className="text-gray-600 dark:text-gray-400 mt-1">
          Welcome back! Here&apos;s your credit card overview.
        </p>
      </div>

      {/* Quick Actions */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="hover:shadow-lg transition-shadow">
          <CardHeader>
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-lg bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400">
                <CreditCard className="h-6 w-6" />
              </div>
              <div>
                <CardTitle className="text-lg">My Cards</CardTitle>
                <CardDescription>Manage your card collection</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-gray-600 dark:text-gray-400 mb-4">
              Add the cards you own to get personalized recommendations.
            </p>
            <Link href="/dashboard/my-cards">
              <Button variant="outline" className="w-full group">
                Manage Cards
                <ArrowRight className="ml-2 h-4 w-4 group-hover:translate-x-1 transition-transform" />
              </Button>
            </Link>
          </CardContent>
        </Card>

        <Card className="hover:shadow-lg transition-shadow">
          <CardHeader>
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-lg bg-green-100 dark:bg-green-900/30 text-green-600 dark:text-green-400">
                <TrendingUp className="h-6 w-6" />
              </div>
              <div>
                <CardTitle className="text-lg">Open a Card</CardTitle>
                <CardDescription>Find the best sign-up bonuses</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-gray-600 dark:text-gray-400 mb-4">
              See which cards are at their all-time high bonuses right now.
            </p>
            <Link href="/dashboard/open-card">
              <Button variant="outline" className="w-full group">
                View Offers
                <ArrowRight className="ml-2 h-4 w-4 group-hover:translate-x-1 transition-transform" />
              </Button>
            </Link>
          </CardContent>
        </Card>

        <Card className="hover:shadow-lg transition-shadow">
          <CardHeader>
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-lg bg-purple-100 dark:bg-purple-900/30 text-purple-600 dark:text-purple-400">
                <ShoppingBag className="h-6 w-6" />
              </div>
              <div>
                <CardTitle className="text-lg">Spending Guide</CardTitle>
                <CardDescription>Optimize every purchase</CardDescription>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <p className="text-sm text-gray-600 dark:text-gray-400 mb-4">
              Find the best card to use for any spending category.
            </p>
            <Link href="/dashboard/spend-guide">
              <Button variant="outline" className="w-full group">
                View Guide
                <ArrowRight className="ml-2 h-4 w-4 group-hover:translate-x-1 transition-transform" />
              </Button>
            </Link>
          </CardContent>
        </Card>
      </div>

      {/* Getting Started Guide */}
      <Card>
        <CardHeader>
          <CardTitle>Getting Started</CardTitle>
          <CardDescription>Follow these steps to maximize your credit card rewards</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <div className="flex items-start gap-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-primary text-primary-foreground text-sm font-semibold">
                1
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Add your current cards</h4>
                <p className="text-sm text-gray-600 dark:text-gray-400">
                  Go to &quot;My Cards&quot; and select all the credit cards you currently have.
                </p>
              </div>
            </div>
            <div className="flex items-start gap-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-primary text-primary-foreground text-sm font-semibold">
                2
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Check for new card opportunities</h4>
                <p className="text-sm text-gray-600 dark:text-gray-400">
                  Browse &quot;Open a Card&quot; to see which cards have their highest sign-up bonuses.
                </p>
              </div>
            </div>
            <div className="flex items-start gap-4">
              <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-primary text-primary-foreground text-sm font-semibold">
                3
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Use the spending guide</h4>
                <p className="text-sm text-gray-600 dark:text-gray-400">
                  Before making a purchase, check &quot;Spending Guide&quot; to see which card gives you the best rewards.
                </p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
