FactoryGirl.define do
  factory :admin_user, aliases: [:admin] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    roles :superadmin
  end
end
