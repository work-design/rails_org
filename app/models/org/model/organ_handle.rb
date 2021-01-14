module Org
  module Model::OrganHandle
    extend ActiveSupport::Concern

    included do
      attribute :record_class, :string
      attribute :record_column, :string
      attribute :name, :string
      attribute :description, :string

      has_many :department_grants, dependent: :destroy
    end

  end
end
