FactoryGirl.define do
  factory :devices_type, class: 'Devices::Type' do
    name { Faker::Lorem.word }
    type { Faker::Lorem.word }
  end
end
