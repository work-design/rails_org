module Org
  module Ext::Account
    extend ActiveSupport::Concern

    included do
      has_many :members, class_name: 'Org::Member', foreign_key: :identity, primary_key: :identity
      has_many :organs, ->{ includes(:organ_domains).order(id: :asc) }, class_name: 'Org::Organ', through: :members
    end

  end
end
