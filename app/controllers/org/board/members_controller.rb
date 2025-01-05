module Org
  class Board::MembersController < Board::BaseController
    before_action :set_member, only: [:show, :edit, :update, :login]

    def login
      current_authorized_token.update member_id: @member.id
      refresh_or_redirect_to({ controller: '/me/home' })
    end

    def logout
      current_authorized_token.update member_id: nil
      refresh_or_redirect_to({ controller: '/me/home' })
    end

    private
    def set_member
      @member = current_user.members.find(params[:id])
    end

  end
end
