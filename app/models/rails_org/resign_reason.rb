module RailsOrg::ResignReason
  extend ActiveSupport::Concern
  included do
    attribute :name, :string
    attribute :position, :integer
    attribute :resigns_count, :integer, default: 0
    
    has_many :resign_references, dependent: :destroy
    has_many :resigns, through: :resign_references

    validates :name, presence: true
  end

end
