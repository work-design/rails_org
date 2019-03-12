class Org::My::DocumentsController < Org::My::BaseController
  before_action :set_document, only: [:show]

  def index
    @documents = Document.page(params[:page])
  end

  def show
  end

  private
  def set_document
    @document = Document.find(params[:id])
  end

end
