class Org::Admin::AuthorizedTokensController < Org::Admin::BaseController
  before_action :set_member
  before_action :set_authorized_token, only: [:show, :edit, :update, :destroy]

  def index
    @authorized_tokens = @member.authorized_tokens
  end

  def show
  end

  def edit
  end

  def update
    @authorized_token.assign_attributes(authorized_token_params)

    unless @authorized_token.save
      render :edit, locals: { model: @authorized_token }, status: :unprocessable_entity
    end
  end

  def destroy
    @authorized_token.destroy
  end

  private
  def set_member
    @member = Member.find params[:member_id]
  end

  def set_authorized_token
    @authorized_token = AuthorizedToken.find(params[:id])
  end

  def authorized_token_params
    params.fetch(:authorized_token, {}).permit(
      :user_id,
      :oauth_user_id,
      :token,
      :expire_at,
      :mock_member
    )
  end

end
