class Api::V1::BalanceController < Api::V1::BaseController
  def show
    account = Account.find(params[:id])

    render json: { balance: currency_number(account.balance) }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Account does not exist.' }, status: :unprocessable_entity
  end

  private

  def currency_number(value)
    view_context.number_to_currency(
      value,
      unit: "R$ ",
      separator: ",",
      delimiter: ".")
  end
end
