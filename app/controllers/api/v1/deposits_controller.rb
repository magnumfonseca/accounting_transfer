class Api::V1::DepositsController < Api::V1::BaseController
  def index
    render json: {}, status: :ok
  end

  def create
    DepositService.call(
      permitted_params[:destination_account_id],
      permitted_params[:amount]
    )
    render json: {}, status: :ok

  rescue Exception => ex
    render json: { errors: ex.message }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit(:destination_account_id, :amount)
  end
end
