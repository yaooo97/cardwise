'use client'

import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { useState } from 'react'

export function CTA() {
  const [email, setEmail] = useState('')
  const [submitted, setSubmitted] = useState(false)

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (email) {
      // In a real app, you'd send this to your backend
      console.log('Email submitted:', email)
      setSubmitted(true)
    }
  }

  return (
    <section className="py-24 bg-primary">
      <div className="container mx-auto px-4">
        <div className="text-center max-w-2xl mx-auto">
          <h2 className="text-3xl font-bold tracking-tight text-white sm:text-4xl">
            Start Maximizing Your Rewards Today
          </h2>
          <p className="mt-4 text-lg text-blue-100">
            Join thousands of savvy credit card users who are earning more with every swipe.
          </p>

          {!submitted ? (
            <form onSubmit={handleSubmit} className="mt-8 flex flex-col sm:flex-row gap-4 justify-center">
              <Input
                type="email"
                placeholder="Enter your email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="max-w-sm bg-white/10 border-white/20 text-white placeholder:text-blue-200 focus:bg-white/20"
                required
              />
              <Button 
                type="submit" 
                variant="secondary"
                size="lg"
                className="bg-white text-primary hover:bg-blue-50"
              >
                Get Started Free
              </Button>
            </form>
          ) : (
            <div className="mt-8 p-4 bg-white/10 rounded-lg">
              <p className="text-white font-medium">
                Thanks for signing up! We&apos;ll be in touch soon.
              </p>
            </div>
          )}

          <p className="mt-4 text-sm text-blue-200">
            Free forever. No credit card required.
          </p>
        </div>
      </div>
    </section>
  )
}
