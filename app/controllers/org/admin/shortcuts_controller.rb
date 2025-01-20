module Org
  class Admin::ShortcutsController < Admin::BaseController
    before_action :set_new_shortcut, only: [:new, :create]

    private
    def set_new_shortcut
      @shortcut = current_member.shortcuts.build(shortcut_params)
    end

    def shortcut_params
      params.fetch(:shortcut, {}).permit(
        :controller,
        :action,
        :business,
        :namespace
      )
    end

  end
end
