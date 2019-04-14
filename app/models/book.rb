class Book < ApplicationRecord
  # belongs_to :author
  belongs_to :author, foreign_key: 'author_id', counter_cache: :true, optional:true
  validates :name, presence: true
  # belongs_to :writer, class_name: 'Author', foreign_key: 'author_id'
end
