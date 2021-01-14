module RailsOrg::Support
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :grade, :integer
    attribute :code, :string

    belongs_to :member, optional: true
    belongs_to :department, optional: true
    belongs_to :organ, optional: true
    belongs_to :supporter, class_name: 'Member'

    has_taxons :department
  end

end
