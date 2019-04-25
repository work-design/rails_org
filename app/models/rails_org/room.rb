module RailsOrg::Room
  extend ActiveSupport::Concern
  included do
    include RailsBookingLocate

    attribute :room_number, :string

    belongs_to :office
  end

  def name
    "#{office.name} #{room_number}"
  end

end
