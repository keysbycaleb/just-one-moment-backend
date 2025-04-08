require 'stripe'
require 'sinatra'

# This is your test secret API key.
Stripe.api_key = 'sk_test_51RBgjgHleUk9GoKc8lKOP7L4lLs0LLsudhtxiah30aFQQ1yVUWlnXqM4y8ezgHzoYBcmiVL8e4M9fySvsbGp5Btx003crkCfwb'

set :static, true
set :port, 4242

YOUR_DOMAIN = 'http://localhost:4242'

post '/create-checkout-session' do
  content_type 'application/json'

  session = Stripe::Checkout::Session.create({
    ui_mode: 'embedded',
    line_items: [{
      # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
      price: '{{PRICE_ID}}',
      quantity: 1,
    }],
    mode: 'payment',
    return_url: YOUR_DOMAIN + '/return.html?session_id={CHECKOUT_SESSION_ID}',
  })

  {clientSecret: session.client_secret}.to_json
end

get '/session-status' do
  session = Stripe::Checkout::Session.retrieve(params[:session_id])

  {status: session.status, customer_email:  session.customer_details.email}.to_json
end