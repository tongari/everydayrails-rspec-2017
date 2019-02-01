class Task < ApplicationRecord
  belongs_to :project

  validates :project, presence: true
  # validates :name, presence: true
  # 学習のためタスク名が重複しないような仕様にしてみる
  validates :name, presence: true, uniqueness: { scope: :project_id }
end
