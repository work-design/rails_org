class Org::Admin::OrganDomainsController < Org::Admin::BaseController
  before_action :set_organ
  before_action :set_organ_domain, only: [:show, :edit, :update, :destroy]

  def index
    @organ_domains = OrganDomain.page(params[:page])
  end

  def new
    @organ_domain = OrganDomain.new
  end

  def create
    @organ_domain = OrganDomain.new(organ_domain_params)

    unless @organ_domain.save
      render :new, locals: { model: @organ_domain }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @organ_domain.assign_attributes(organ_domain_params)

    unless @organ_domain.save
      render :edit, locals: { model: @organ_domain }, status: :unprocessable_entity
    end
  end

  def destroy
    @organ_domain.destroy
  end

  private
  def set_organ
    @organ = Organ.find params[:organ_id]
  end

  def set_organ_domain
    @organ_domain = OrganDomain.find(params[:id])
  end

  def organ_domain_params
    params.fetch(:organ_domain, {}).permit(
      :domain,
      :port,
      :subdomain,
      :host,
      :appid
    )
  end

end
