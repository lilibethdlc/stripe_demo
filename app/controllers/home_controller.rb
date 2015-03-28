class HomeController < ApplicationController
  def charge_index
    flash[:notice] = charge

    redirect_to root_url
  end

  def charge_custom
    flash[:notice] = charge

    redirect_to custom_url
  end

  def charge
    Stripe.api_key = "sk_test_inYgDN1LPX9fmtUSPUFVsD5W"

    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => 2000, # amount in cents
        :currency => "usd",
        :source => token,
        :description => "abc@example.com"
      )

      msg = "Succesfully processed Credit Card"
    rescue Stripe::CardError => e
      err = e.json_body[:error]
      msg = "status: #{e.http_status} type: #{err[:type]} code: #{err[:code]}
      param: #{err[:param]} message: #{err[:message]}"
    rescue Stripe::InvalidRequestError => e
      msg = "Invalid parameters were supplied to Stripe's API"
    rescue Stripe::AuthenticationError => e
      msg = "Authentication with Stripe's API failed"
    rescue Stripe::APIConnectionError => e
      msg = "Network communication with Stripe failed"
    rescue Stripe::StripeError => e
      msg = "Some other Stripe error"
    rescue => e
      msg = "Some other non Stripe error"
    end

    msg
  end
end
