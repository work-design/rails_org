class Room < ApplicationRecord
  include RailsBookingLocate

  attribute :room_number, :string

  belongs_to :office

  def name
    "#{office.name} #{room_number}"
  end

end
