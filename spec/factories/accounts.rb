FactoryGirl.define do
  factory :account do
    name Forgery::Name.full_name
    balance 1027.0
  end
end
