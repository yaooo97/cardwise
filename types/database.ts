export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      credit_cards: {
        Row: {
          id: string
          name: string
          issuer: string
          annual_fee: number
          current_sub: number
          highest_sub: number
          is_at_highest: boolean
          sub_requirements: string | null
          sub_end_date: string | null
          point_type: string | null
          transfer_partners: string[] | null
          image_url: string | null
          apply_url: string | null
          official_url: string | null
          card_color: string | null
          card_color_end: string | null
          description: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          name: string
          issuer: string
          annual_fee: number
          current_sub: number
          highest_sub: number
          is_at_highest?: boolean
          sub_requirements?: string | null
          sub_end_date?: string | null
          point_type?: string | null
          transfer_partners?: string[] | null
          image_url?: string | null
          apply_url?: string | null
          official_url?: string | null
          card_color?: string | null
          card_color_end?: string | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          name?: string
          issuer?: string
          annual_fee?: number
          current_sub?: number
          highest_sub?: number
          is_at_highest?: boolean
          sub_requirements?: string | null
          sub_end_date?: string | null
          point_type?: string | null
          transfer_partners?: string[] | null
          image_url?: string | null
          apply_url?: string | null
          official_url?: string | null
          card_color?: string | null
          card_color_end?: string | null
          description?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      card_rewards: {
        Row: {
          id: string
          card_id: string
          category: string
          reward_rate: number
          reward_unit: string
          cap_amount: number | null
          notes: string | null
        }
        Insert: {
          id?: string
          card_id: string
          category: string
          reward_rate: number
          reward_unit: string
          cap_amount?: number | null
          notes?: string | null
        }
        Update: {
          id?: string
          card_id?: string
          category?: string
          reward_rate?: number
          reward_unit?: string
          cap_amount?: number | null
          notes?: string | null
        }
      }
      user_cards: {
        Row: {
          id: string
          user_id: string
          card_id: string
          acquired_date: string | null
          annual_fee_date: string | null
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          card_id: string
          acquired_date?: string | null
          annual_fee_date?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          card_id?: string
          acquired_date?: string | null
          annual_fee_date?: string | null
          created_at?: string
        }
      }
      spending_categories: {
        Row: {
          id: string
          name: string
          display_name: string
          icon: string
          description: string | null
        }
        Insert: {
          id?: string
          name: string
          display_name: string
          icon: string
          description?: string | null
        }
        Update: {
          id?: string
          name?: string
          display_name?: string
          icon?: string
          description?: string | null
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}

// Helper types
export type CreditCard = Database['public']['Tables']['credit_cards']['Row']
export type CardReward = Database['public']['Tables']['card_rewards']['Row']
export type UserCard = Database['public']['Tables']['user_cards']['Row']
export type SpendingCategory = Database['public']['Tables']['spending_categories']['Row']

// Extended types for UI
export type CreditCardWithRewards = CreditCard & {
  rewards: CardReward[]
}

export type UserCardWithDetails = UserCard & {
  card: CreditCard
}
