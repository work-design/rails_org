class Org::Panel::OrganTokensController < Org::Panel::BaseController
  before_action :set_organ

  def index
    @organ_tokens = current_organ.organ_tokens.page(params[:page])
  end

  def new
    @organ_token = current_organ.organ_tokens.build
  end

  def create
    @organ_token = current_organ.organ_tokens.build(organ_token_params)

    if @organ_token.save
      redirect_to panel_organ_tokens_url(current_organ), notice: 'Organ token was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @organ_token = current_organ.organ_tokens.find(params[:id])
    @organ_token.destroy
    redirect_to panel_organ_tokens_url(current_organ), notice: 'Organ token was successfully destroyed.'
  end

  private
  def set_organ
    @organ = current_organ
  end

  def organ_token_params
    params.fetch(:organ_token).permit(:user_id, :member_id, :token)
  end

end
