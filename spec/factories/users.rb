FactoryBot.define do
  factory :user do
    name { "ashborn" }
    email { "ashborn@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end

  factory :second_user, class: User do
    name { "capi" }
    email { "capi@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { true }
  end
end
