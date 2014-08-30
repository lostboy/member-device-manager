FactoryGirl.define do
  factory :devices_type, class: 'Devices::Type' do
    name { Faker::Lorem.word }
    kind { Faker::Lorem.word }
  end
end
