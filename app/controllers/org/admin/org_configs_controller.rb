class Org::Admin::OrgConfigsController < Org::Admin::BaseController
  before_action :set_org_config, only: [:show, :edit, :update, :destroy]

  def index
    q_params = default_params
    @org_configs = OrgConfig.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def new
    @org_config = OrgConfig.new
  end

  def create
    @org_config = OrgConfig.new(org_config_params)

    unless @org_config.save
      render :new, locals: { model: @org_config }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @org_config.assign_attributes(org_config_params)

    unless @org_config.save
      render :edit, locals: { model: @org_config }, status: :unprocessable_entity
    end
  end

  def destroy
    @org_config.destroy
  end

  private
  def set_org_config
    @org_config = OrgConfig.find(params[:id])
  end

  def org_config_params
    params.fetch(:org_config, {}).permit(
      :name,
      :description,
      :record_class,
      :record_column,
      job_title_ids: []
    )
  end

end
