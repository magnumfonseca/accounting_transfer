require "rails_helper"

describe DepositService do
  subject { described_class.call(destination_account_id, amount) }


  context "when destination_account is valid" do
    let(:account) { create :account, balance: 0 }
    let(:destination_account_id) { account.id }

    context "when amount is valid" do
      let(:amount) { 10 }

      it "makes a deposit to account" do
        expect(subject).to be_truthy

        account.reload

        expect(account.balance).to eq amount
      end
    end

    context "when amount is invalid" do
      let(:amount) { -2 }

      it "does not makes a deposit on account" do
        expect(subject).to be_falsey

        account.reload

        expect(account.balance).to be_zero
      end
    end
  end

  context "when destination_account is invalid" do
    let(:destination_account_id) { 123 }
    let(:amount) { 10 }

    it "does not makes a deposit on account" do
      expect(subject).to be_falsey
    end
  end
end
