require "rails_helper"

describe Api::V1::HistoryController, type: :request do
  context "source account is valid" do
    let(:source_amount) { 1000 }
    let(:source_account) { create :account, balance: source_amount }

    before do
      DepositService.call(source_account.id, 100)
    end

    it "get history" do
      get "/api/v1/accounts/#{source_account.id}/history"

      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body.first["amount"]). to eq "100.0"
    end
  end
end

