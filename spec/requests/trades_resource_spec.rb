require "rails_helper"

describe Api::V1::TradesController, type: :request do
  let(:trade_params) do
    {
      source_account_id: source_account.id,
      destination_account_id: destination_account.id,
      amount: amount
    }
  end

  let(:source_amount) { 1000 }
  let(:source_account) { create :account, balance: source_amount }

  context "destination account is valid" do
    let(:destination_amount) { 0 }
    let(:destination_account) { create :account, balance: destination_amount }

    context "has enough money" do
      let(:amount) { 500 }

      it "make a transfer" do
        post "/api/v1/trades", params: trade_params
        destination_account.reload

        expect(response.status).to eq(200)
        expect(destination_account.balance).to eq(amount)
      end
    end

    context "hos not enough money" do
      let(:amount) { 1500 }

      it "does not make a transfer" do
        post "/api/v1/trades", params: trade_params

        body = JSON.parse(response.body)
        destination_account.reload

        expect(response.status).to eq(422)
        expect(body["errors"]).to eq 'Not enough money on the source account.'

        expect(destination_account.balance).to be_zero
      end
    end
  end

  context "destination account is invalid" do
    let(:amount) { 500 }
    let(:destination_amount) { 0 }
    let(:destination_account) { create :account, balance: destination_amount }

    it "does not make a transfer" do
      destination_account.destroy
      post "/api/v1/trades", params: trade_params

      body = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(body["errors"]).to eq 'Destination account does not exists.'
    end
  end
end
