class Band < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true

end
