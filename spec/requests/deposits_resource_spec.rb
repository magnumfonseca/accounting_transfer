require "rails_helper"

describe Api::V1::DepositsController, type: :request do
  let(:trade_params) do
    {
      destination_account_id: destination_account.id,
      amount: amount
    }
  end

  let(:amount) { 500 }

  context "destination account is valid" do
    let(:destination_account) { create :account, balance: 0 }


    it "make a deposit" do
      post "/api/v1/deposits", params: trade_params
      destination_account.reload

      expect(response.status).to eq(200)
      expect(destination_account.balance).to eq(amount)
    end
  end

  context "destination account is invalid" do
    let(:destination_account) { create :account, balance: 0 }

    it "does not make a deposit" do
      destination_account.destroy
      post "/api/v1/deposits", params: trade_params

      body = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(body["errors"]).to eq 'Destination account does not exists.'
    end
  end
end
