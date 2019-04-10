class Product < ApplicationRecord
  validates :legacy_code, format: { with: /\A[a-zA-z]+\z/ }
end
