FactoryGirl.define do
  factory :devices_device, aliases: [:device], class: 'Devices::Device' do
    mac_address { Faker::Internet.mac_address }
    ip_address { Faker::Internet.ip_v4_address }
    association :type, factory: :devices_type
    association :member, factory: :member
  end
end
