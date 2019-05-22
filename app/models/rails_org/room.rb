module RailsOrg::Room
  extend ActiveSupport::Concern
  included do
    include RailsBooking::Locate

    attribute :room_number, :string
    belongs_to :organ
  end

  def name
    prefix = organ.name_short.presence || organ.name
    "#{prefix} #{room_number}"
  end

end
