class Org::Our::BaseController < OurController
  before_action :require_organ

end unless defined? Org::Our::BaseController
