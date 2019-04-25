module RailsOrg::ResignResignReason
  extend ActiveSupport::Concern
  included do
    belongs_to :resign
    belongs_to :resign_reason, counter_cache: :resigns_count
  end

end
