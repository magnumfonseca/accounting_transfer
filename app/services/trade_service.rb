class TradeService
  attr_reader :source_account, :destination_account, :amount

  def self.call(source_account_id, destination_account_id, amount)
    new(source_account_id, destination_account_id, amount).call
  end

  def initialize(source_account_id, destination_account_id, amount)
    @source_account = Account.find(source_account_id) rescue nil
    @destination_account = Account.find(destination_account_id) rescue nil
    @amount = amount
  end

  def call
    valid?
    ActiveRecord::Base.transaction do
      create_trades
      move_amount
    end
  end

  private

  def create_trades
    Trade.create!(account_id: source_account.id, amount: - amount)
    Trade.create!(account_id: destination_account.id, amount: amount)
  end

  def move_amount
    source_account.update_attributes(balance: source_account.balance - amount)
    destination_account.update_attributes(balance: destination_account.balance + amount)
  end

  def valid?
    raise 'Source account does not exists.' unless source_account
    raise 'Destination account does not exists.' unless destination_account
    raise 'Not enough money on the source account.' if amount > source_account.balance
  end
end
