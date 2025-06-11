module Org
  class Board::MembersController < Board::BaseController
    before_action :set_member, only: [:show, :edit, :update]

    def login
      @member = current_account.members.find(params[:id])
      current_authorized_token.update member_id: @member.id
      refresh_or_redirect_to({ controller: '/me/home' })
    end

    def user_login
      @member = current_user.members.find(params[:id])
      current_authorized_token.update member_id: @member.id
      refresh_or_redirect_to({ controller: '/me/home' })
    end

    def logout
      current_authorized_token.update member_id: nil

      if RailsOrg.independent && request.subdomain == 'admin'
        refresh_or_redirect_to({ controller: '/me/home' })
      else
        refresh_or_redirect_to({ controller: 'org/board/organs' })
      end
    end

    private
    def set_member
      @member = current_user.members.find(params[:id])
    end

  end
end
