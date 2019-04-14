class Author < ApplicationRecord
  # has_many :books, dependent: :destroy, inverse_of: 'writer'
  has_many :books, dependent: :destroy
end

