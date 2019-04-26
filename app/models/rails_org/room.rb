module RailsOrg::Room
  extend ActiveSupport::Concern
  included do
    include RailsBooking::Locate

    attribute :room_number, :string

    belongs_to :office
  end

  def name
    "#{office.name} #{room_number}"
  end

end
