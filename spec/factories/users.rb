FactoryBot.define do
  factory :user do
    login {"juan "}
    name {"Juan Pablo Gil" }
    url {"http://Example.com" }
    avatar_url  {"http://example.com/avatar"}
    provider  {"github" }
  end
end
