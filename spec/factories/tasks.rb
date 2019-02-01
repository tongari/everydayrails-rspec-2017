FactoryBot.define do
  factory :task do
    # name 'My Task'
    # 学習のためタスク名が重複しないような仕様にしてみる
    sequence(:name) { |n| "My Task #{n}"}
    association :project
  end
end
