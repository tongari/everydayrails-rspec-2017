class Account < ApplicationRecord
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value}は予約済みです"}
end
