class Org::Admin::DocumentsController < Org::Admin::BaseController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.page(params[:page])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)

    if @document.save
      redirect_to admin_documents_url, notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to admin_documents_url, notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @document.destroy
    redirect_to admin_documents_url, notice: 'Document was successfully destroyed.'
  end

  private
  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.fetch(:document, {}).permit(:name, :file)
  end

end
