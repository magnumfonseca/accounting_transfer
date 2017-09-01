class Api::V1::TradesController < Api::V1::BaseController
  def index
    render json: {}, status: :ok
  end

  def create
    TradeService.call(
      permitted_params[:source_account_id],
      permitted_params[:destination_account_id],
      permitted_params[:amount]
    )
    render json: {}, status: :ok

  rescue Exception => ex
    render json: { errors: ex.message }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit(:source_account_id, :destination_account_id, :amount)
  end
end
