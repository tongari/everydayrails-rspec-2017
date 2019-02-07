FactoryBot.define do
  factory :note do
    message 'My import note.'
    association :project
    # association :user
    user { project.owner }

    trait :with_attachment do
      attachment { File.new("#{Rails.root}/spec/files/attachment.jpg") }
    end
  end
end
