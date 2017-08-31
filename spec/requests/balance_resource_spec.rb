require "rails_helper"

describe Api::V1::BalanceController, type: :request do
  context "source account is valid" do
    let(:source_amount) { 1000 }
    let(:source_account) { create :account, balance: source_amount }

    it "get balance" do
      get "/api/v1/balance/#{source_account.id}"

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body["balance"]).to eq('R$ 1.000,00')
    end
  end

  context "source_account does not exists" do
    let(:source_account) { create :account }

    it "get balance" do
      source_account.destroy

      get "/api/v1/balance/#{source_account.id}"

      body = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(body["errors"]).to eq('Account does not exist.')
    end
  end
end

