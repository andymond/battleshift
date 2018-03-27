FactoryBot.define do
  factory :user do
    name "Opakawagalaga Eupanifahorious"
    sequence :email { |n| "Opakawagalaga#{n}@Eupanifahorious.com" }
    password "Opakawagalaga's Wife"
    password_confirmation "Opakawagalaga's Wife"
  end
end
