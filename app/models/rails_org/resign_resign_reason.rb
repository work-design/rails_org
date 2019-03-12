class ResignResignReason < ApplicationRecord
  belongs_to :resign
  belongs_to :resign_reason, counter_cache: :resigns_count

end
