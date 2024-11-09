module Org
  module Ext::User
    extend ActiveSupport::Concern

    included do
      has_many :created_organs, class_name: 'Org::Organ', foreign_key: :creator_id

      after_save :copy_avatar_to_members, if: -> { attachment_changes['avatar'].present? }
    end

    def members
      identities = accounts.pluck(:identity)
      uids = oauth_users.pluck(:uid)
      if identities.blank?
        Org::Member.where(wechat_openid: uids)
      elsif uids.blank?
        Org::Member.where(identity: identities)
      else
        Org::Member.where(identity: identities).or(Org::Member.where(wechat_openid: uids))
      end
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
