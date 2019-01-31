FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name 'Hoge'
    last_name 'Fuga'
    sequence(:email) {|n| "hoge_#{n}@gmail.com"}
    password 'hogehoge'
  end
end
