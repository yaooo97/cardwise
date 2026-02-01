import { CreditCard } from 'lucide-react'
import Link from 'next/link'

export function Footer() {
  return (
    <footer className="bg-white dark:bg-slate-900 border-t border-gray-200 dark:border-gray-800">
      <div className="container mx-auto px-4 py-12">
        <div className="flex flex-col md:flex-row justify-between items-center">
          <div className="flex items-center gap-2 mb-6 md:mb-0">
            <CreditCard className="h-6 w-6 text-primary" />
            <span className="text-xl font-bold text-gray-900 dark:text-white">CardWise</span>
          </div>
          
          <nav className="flex flex-wrap justify-center gap-6 mb-6 md:mb-0">
            <Link href="#features" className="text-gray-600 dark:text-gray-400 hover:text-primary transition-colors">
              Features
            </Link>
            <Link href="/login" className="text-gray-600 dark:text-gray-400 hover:text-primary transition-colors">
              Sign In
            </Link>
            <Link href="/signup" className="text-gray-600 dark:text-gray-400 hover:text-primary transition-colors">
              Sign Up
            </Link>
          </nav>
          
          <p className="text-sm text-gray-500 dark:text-gray-500">
            © {new Date().getFullYear()} CardWise. All rights reserved.
          </p>
        </div>
        
        <div className="mt-8 pt-8 border-t border-gray-200 dark:border-gray-800">
          <p className="text-xs text-center text-gray-500 dark:text-gray-500">
            CardWise is a free tool for informational purposes only. 
            We do not provide financial advice. Always do your own research before applying for credit cards.
          </p>
        </div>
      </div>
    </footer>
  )
}
