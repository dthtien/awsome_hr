FactoryBot.define do
  factory :user do
    username {'test'}
    name {'Test'}
    password {'123123'}
    password_confirmation {'123123'}
  end
end
