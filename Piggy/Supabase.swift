import Supabase
import Foundation

let supabase = SupabaseClient(
    supabaseURL: URL(string: supabaseProjectURL)!,
    supabaseKey: supabaseAPIKey
)
