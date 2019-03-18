class Room < ApplicationRecord
  belongs_to :office
  attribute :room_number, :string


end

# :office, :string
# :meeting_root, :string
#
