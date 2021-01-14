module Org
  module Model::DepartmentGrant
    extend ActiveSupport::Concern

    included do
      belongs_to :organ, optional: true
      belongs_to :organ_handle
      belongs_to :department, optional: true
      belongs_to :job_title, optional: true
    end

  end
end
