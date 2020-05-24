FactoryBot.define do
  factory :card do
    user_id {"00"}
    customer_id {"00"}
    card_id     {"00"}
    user       {create(:user)}
  end
end
