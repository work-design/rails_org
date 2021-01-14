module Org
  module Model::User
    extend ActiveSupport::Concern

    included do
      has_many :members, dependent: :nullify
      has_many :organs, -> { distinct }, through: :members
      after_save :copy_avatar_to_members, if: -> { attachment_changes['avatar'].present? }
    end

    def available_account_identities
      accounts.where.not(identity: members.pluck(:identity)).confirmed
    end

    def copy_avatar_to_members
      members.each do |member|
        member.avatar.attach attachment_changes['avatar'].blob if member.avatar.blank?
      end
    end

    def init_avatar_to_members
      members.each do |member|
        member.avatar.attach avatar_blob if avatar_blob
      end
    end

  end
end
