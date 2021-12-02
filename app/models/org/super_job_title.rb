module Org
  class SuperJobTitle < ApplicationRecord
    include Roled::Ext::JobTitle if defined? RailsRole # must included before RailsOrg::SuperJobTitle
    include Model::SuperJobTitle
  end
end
