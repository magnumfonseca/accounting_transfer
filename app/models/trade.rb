class Trade < ApplicationRecord
  belongs_to :account

  scope :by_account, -> (account_id) { where(account_id: account_id) }

  scope :ordered, -> { order(created_at: :desc) }

  def as_json
    {
      amount: amount,
      date: I18n.l(created_at, format: :short)
    }
  end
end
