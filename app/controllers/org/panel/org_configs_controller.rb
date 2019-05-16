class Org::Panel::OrgConfigsController < Org::Panel::BaseController
  before_action :set_org_config, only: [:show, :edit, :update, :destroy]

  def index
    @org_configs = OrgConfig.page(params[:page])
  end

  def new
    @org_config = OrgConfig.new
  end

  def create
    @org_config = OrgConfig.new(org_config_params)

    respond_to do |format|
      if @org_config.save
        format.html.phone
        format.html { redirect_to panel_org_configs_url }
        format.js { redirect_back fallback_location: panel_org_configs_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: panel_org_configs_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @org_config.assign_attributes(org_config_params)

    respond_to do |format|
      if @org_config.save
        format.html.phone
        format.html { redirect_to panel_org_configs_url }
        format.js { redirect_back fallback_location: panel_org_configs_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: panel_org_configs_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @org_config.destroy
    redirect_to panel_org_configs_url
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
      :job_title_id
    )
  end

end
