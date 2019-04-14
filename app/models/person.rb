class Person < ApplicationRecord  
  # validates :email, confirmation: { case_sensitive: false }
  # validates :email_confirmation, presence: true
  # validates :name, absence: true, presence: true
  validates :name, presence: true, optional: true
  # validates_with GoodnessValidator
end
