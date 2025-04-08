// This is your test secret API key.
const stripe = Stripe("pk_test_51RBgjgHleUk9GoKcEacgXKUChwN84pEog8J97JoDbBu4fE4sb7nxA6C41ugVs0Vmt6UYdvvOfUrQFbMh1onJiNcs00aQPHNJ0q");

initialize();

// Create a Checkout Session
async function initialize() {
  const fetchClientSecret = async () => {
    const response = await fetch("/create-checkout-session", {
      method: "POST",
    });
    const { clientSecret } = await response.json();
    return clientSecret;
  };

  const checkout = await stripe.initEmbeddedCheckout({
    fetchClientSecret,
  });

  // Mount Checkout
  checkout.mount('#checkout');
}