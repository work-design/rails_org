module Org
  module Model::Account
    extend ActiveSupport::Concern

    included do
      has_many :members, class_name: 'Org::Member', foreign_key: :identity, primary_key: :identity
      has_many :organs, ->{ includes(:organ_domain).order(id: :asc) }, class_name: 'Org::Organ', through: :members
      after_save :sync_to_members, if: -> { (saved_changes.keys & ['identity', 'user_id', 'confirmed']).present? }
    end

    def sync_to_members
      if confirmed? && self.user_id
        members.update_all(user_id: self.user_id)
      end
    end

  end
end
