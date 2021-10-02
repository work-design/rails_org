module Org
  class Member < ApplicationRecord
    include Model::Member
    include Profiled::Model::Profile if defined? RailsProfile
    include Roled::Model::User if defined? RailsRole
    include Wechat::Ext::Member if defined? RailsWechat
  end
end
