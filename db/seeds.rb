50.times do
  account = Account.create!(name: Forgery::Name.full_name, balance: 0)
  DepositService.call(account.id, rand(100..1000))
end
