module Org
  class Member < ApplicationRecord
    include Model::Member
    include Roled::Ext::Member if defined? RailsRole
    include Wechat::Ext::Member if defined? RailsWechat
  end
end
