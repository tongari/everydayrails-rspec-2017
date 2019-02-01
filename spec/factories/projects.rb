FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Test Project #{n}"}
    description 'Sample project for testing purposes.'
    due_on 1.week.from_now
    association :owner

    # メモ付きのプロジェクト
    trait :with_notes do
      after(:create) { |project|
        create_list(:note, 5, project: project)
      }
    end

    # タスク付きのプロジェクト
    trait :with_tasks do
      after(:create) { |project|
        create_list(:task, 5, project: project)
      }
    end

    # 昨日が締め切りのプロジェクト
    # factory :project_due_yesterday do
    trait :due_yesterday do
      due_on 1.day.ago
    end

    # 今日が締め切りのプロジェクト
    # factory :project_due_today do
    trait :due_today do
      due_on Date.current.in_time_zone
    end

    # 明日が締め切りのプロジェクト
    # factory :project_due_tomorrow do
    trait :due_tomorrow do
      due_on 1.day.from_now
    end
  end
end
