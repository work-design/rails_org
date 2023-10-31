module Org
  class Member < ApplicationRecord
    include Model::Member
    include Roled::Ext::Member
    include Wechat::Ext::Member if defined? RailsWechat
    include Notice::Ext::Member if defined? RailsNotice
    include Notice::Ext::Setting if defined? RailsNotice
    include Crm::Ext::Member if defined? RailsCrm
  end
end
