module Org
  class JobTitle < ApplicationRecord
    include Roled::Model::User if defined? RailsRole # must included before RailsOrg::JobTitle
    include Model::JobTitle
  end
end
