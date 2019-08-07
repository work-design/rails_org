class Org::Org::HomeController < Org::Org::BaseController

  def index
    respond_to do |format|
      format.html.phone
      format.html
    end
  end

end
