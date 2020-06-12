class MemberSuper < ApplicationRecord
  include RailsOrg::MemberSuper
end unless defined? MemberSuper
