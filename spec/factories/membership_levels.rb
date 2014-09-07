# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership_level, class: 'Membership::Level' do
    name { Faker::Lorem.word }
    price { Faker::Number.number(2) }
    nexudus_updated_at { 2.hours.ago }
    nexudus_created_at { 2.days.ago }
    nexudus_id Faker::Number.number(10)
  end
end
