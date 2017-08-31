class DepositService
  attr_reader :destination_account, :amount

  def self.call(destination_account_id, amount)
    new(destination_account_id, amount).call
  end

  def initialize(destination_account_id, amount)
    @destination_account = Account.find(destination_account_id) rescue nil
    @amount = amount.to_f
  end

  def call
    valid?
    ActiveRecord::Base.transaction do
      Trade.create!(account_id: destination_account.id, amount: amount)
      destination_account.update_attributes(balance: destination_account.balance + amount)
    end
  end

  private

  def valid?
    raise 'Not enough amount to deposit.' if amount <= 0
    raise 'Destination account does not exists.' unless destination_account
  end
end
