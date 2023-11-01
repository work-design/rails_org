module Org
  module Ext::AuthorizedToken
    extend ActiveSupport::Concern

    included do
      attribute :mock_member, :boolean, default: false

      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :ident_member, class_name: 'Org::Member', foreign_key: :identity, primary_key: :identity, optional: true
    end

    def mocked_member
      if mock_member
        ident_member
      else
        nil
      end
    end

  end
end
