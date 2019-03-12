class Organ < ApplicationRecord
  has_many :memberships
  has_one_attached :logo

end
