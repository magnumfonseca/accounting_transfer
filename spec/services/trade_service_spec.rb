require "rails_helper"

describe TradeService do
  subject { described_class.call(source_account.id, destination_account.id, amount) }

  let(:source_amount) { 1000 }
  let(:source_account) { create :account, balance: source_amount }

  context "destination account is valid" do
    let(:destination_amount) { 10 }
    let(:destination_account) { create :account, balance: destination_amount }

    context "has enough money" do
      let(:amount) { source_account.balance - 100 }
      it "makes a money transfer" do
        expect(subject).to be_truthy

        source_account.reload
        destination_account.reload

        expect(source_account.balance).to eq(source_amount - amount)
        expect(destination_account.balance).to eq(destination_amount + amount)
      end
    end

    context "has not enough money" do
      let(:amount) { source_account.balance + 100 }

      it "does not make a transfer" do
        expect { subject }.to raise_error('Not enough money on the source account.')

        expect(source_account.balance).to eq(source_amount)
        expect(destination_account.balance).to eq(destination_amount)
      end
    end
  end
end
