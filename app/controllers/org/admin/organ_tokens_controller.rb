class Org::Admin::OrganTokensController < RailsOrg.config.admin_class.constantize
  before_action :set_organ

  def index
    @organ_tokens = @organ.organ_tokens.page(params[:page])
  end

  def new
    @organ_token = @organ.organ_tokens.build
  end


  def create
    @organ_token = @organ.organ_tokens.build(organ_token_params)

    if @organ_token.save
      redirect_to admin_organ_tokens_url(@organ), notice: 'Organ token was successfully created.'
    else
      render :new
    end
  end


  def destroy
    @organ_token = @organ.organ_tokens.find(params[:id])
    @organ_token.destroy
    redirect_to admin_organ_tokens_url(@organ), notice: 'Organ token was successfully destroyed.'
  end

  private
  def set_organ
    @organ = Organ.find(params[:organ_id])
  end

  def organ_token_params
    params.fetch(:organ_token).permit(:user_id, :member_id, :token)
  end

end
