class DepositService
  attr_reader :destination_account, :amount

  def self.call(destination_account_id, amount)
    new(destination_account_id, amount).call
  end

  def initialize(destination_account_id, amount)
    @destination_account = Account.find(destination_account_id) rescue nil
    @amount = amount
  end

  def call
    return false unless valid?
    ActiveRecord::Base.transaction do
      Trade.create!(account_id: destination_account.id, amount: amount)
      destination_account.update_attributes(balance: destination_account.balance + amount)
    end
  end

  private

  def valid?
    return false if amount <= 0
    return false unless destination_account.present?

    true
  end
end
