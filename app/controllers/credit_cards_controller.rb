class CreditCardsController < ApplicationController
  before_action :set_payjp_api_key, only: %i[create show destroy]

  # TODO: 顧客情報が保存されなかった場合のエラー処理追加する
  def create
    redirect_to current_user and return if params['payjp-token'].blank?

    customer = Payjp::Customer.create(
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
    )
    @card = current_user.build_credit_card(customer_id: customer.id, card_id: customer.default_card)
    if @card.save
      redirect_to @card
    else
      redirect_to current_user
    end
  end

  def show
    card = current_user.credit_card
    if card
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = customer.cards.retrieve(card.card_id)
    end
  end

  def destroy
    redirect_to current_user and return unless current_user.credit_card

    customer = Payjp::Customer.retrieve(current_user.credit_card.customer_id)
    customer.delete
    current_user.credit_card.delete
    redirect_to current_user
  end

  private

  def set_payjp_api_key
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
  end
end