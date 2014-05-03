Rails.configuration.stripe = {
  :publishable_key => "pk_test_vE0IID3mCxRvB5MOHq5XNU9w",
  :secret_key      => "sk_test_GljXNhf47zhlRwO7DHYmtgSN"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]