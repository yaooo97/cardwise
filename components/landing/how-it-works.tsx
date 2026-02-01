const steps = [
  {
    step: '01',
    title: 'Add Your Cards',
    description: 'Select the credit cards you already have from our database of 50+ popular cards.',
  },
  {
    step: '02',
    title: 'Get Recommendations',
    description: 'See which cards are at their highest bonuses and which card to use for each purchase.',
  },
  {
    step: '03',
    title: 'Maximize Rewards',
    description: 'Follow our recommendations to earn the most points, miles, and cashback possible.',
  },
]

export function HowItWorks() {
  return (
    <section className="py-24 bg-gray-50 dark:bg-slate-800">
      <div className="container mx-auto px-4">
        <div className="text-center mb-16">
          <h2 className="text-3xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-4xl">
            How It Works
          </h2>
          <p className="mt-4 text-lg text-gray-600 dark:text-gray-400">
            Get started in minutes with three simple steps
          </p>
        </div>

        <div className="grid grid-cols-1 gap-12 md:grid-cols-3 max-w-5xl mx-auto">
          {steps.map((item, index) => (
            <div key={item.step} className="relative">
              {/* Connector line */}
              {index < steps.length - 1 && (
                <div className="hidden md:block absolute top-8 left-full w-full h-0.5 bg-gradient-to-r from-primary to-transparent" />
              )}
              
              <div className="text-center">
                <div className="inline-flex h-16 w-16 items-center justify-center rounded-full bg-primary text-white text-xl font-bold mb-6">
                  {item.step}
                </div>
                <h3 className="text-xl font-semibold text-gray-900 dark:text-white mb-3">
                  {item.title}
                </h3>
                <p className="text-gray-600 dark:text-gray-400">
                  {item.description}
                </p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
