module Org
  module Model::Shortcut
    extend ActiveSupport::Concern

    included do
      attribute :controller, :string
      attribute :action, :integer
      attribute :business, :string
      attribute :namespace, :string

      belongs_to :member
    end

  end
end
