FactoryBot.define do
  factory :access_token do
    #token { '1234567890' }
    association :user
  end
end
