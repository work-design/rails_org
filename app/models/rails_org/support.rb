module RailsOrg::Support
  extend ActiveSupport::Concern
  included do
    attr_accessor :department_ancestors

    belongs_to :member, optional: true
    belongs_to :department, optional: true
    belongs_to :office, optional: true
    belongs_to :supporter, class_name: 'Member'
  end

end
