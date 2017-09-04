class Api::V1::HistoryController < Api::V1::BaseController
  def index
    trades = Trade.
      by_account(params[:id]).
      ordered

    render json: trades.as_json
  end
end
