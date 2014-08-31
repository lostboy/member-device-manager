FactoryGirl.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    active true
    nexudus_user_id { rand(1000..9999) }
    nexudus_updated_at { 2.hours.ago }
    nexudus_created_at { 2.days.ago }
    nexudus_id { SecureRandom.uuid }
  end
end
