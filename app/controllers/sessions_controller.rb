class SessionsController < ApplicationController
  def new
  end

  def create
    account = Account.find_by(id: permitted_params[:account_id])
    if account.present? 
      redirect_to account_path(account)
    else
      flash.now[:error] = "Account not found"
      render :new
    end
  end
  
  def permitted_params
    params.require(:session).permit(:account_id)
  end
end
