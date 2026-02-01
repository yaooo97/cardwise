import { CreditCard, ShoppingBag, Calculator } from 'lucide-react'

const features = [
  {
    name: 'Find Best Sign-Up Bonuses',
    description:
      'Track which cards are at their all-time high bonuses. Never miss a great SUB opportunity again.',
    icon: CreditCard,
    color: 'bg-blue-500',
  },
  {
    name: 'Optimize Every Purchase',
    description:
      'Select your spending category and instantly see which card in your wallet gives you the best return.',
    icon: ShoppingBag,
    color: 'bg-green-500',
  },
  {
    name: 'Annual Fee Calculator',
    description:
      'Know exactly which cards are worth keeping based on your spending habits and the card benefits.',
    icon: Calculator,
    color: 'bg-purple-500',
  },
]

export function Features() {
  return (
    <section id="features" className="py-24 bg-white dark:bg-slate-900">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-4xl">
            Everything You Need to Maximize Rewards
          </h2>
          <p className="mt-4 text-lg text-gray-600 dark:text-gray-400 max-w-2xl mx-auto">
            CardWise provides all the tools a credit card enthusiast needs to make smart decisions.
          </p>
        </div>

        <div className="grid grid-cols-1 gap-8 md:grid-cols-3">
          {features.map((feature) => (
            <div
              key={feature.name}
              className="relative rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-slate-800 p-8 shadow-sm hover:shadow-lg transition-shadow"
            >
              <div className={`inline-flex h-12 w-12 items-center justify-center rounded-lg ${feature.color} text-white mb-5`}>
                <feature.icon className="h-6 w-6" />
              </div>
              <h3 className="text-xl font-semibold text-gray-900 dark:text-white mb-3">
                {feature.name}
              </h3>
              <p className="text-gray-600 dark:text-gray-400">
                {feature.description}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
