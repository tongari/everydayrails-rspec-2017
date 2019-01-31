FactoryBot.define do
  factory :note do
    message 'My import note.'
    association :project
    # association :user
    user { project.owner }
  end
end
