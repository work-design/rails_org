module OrgController::Me
  extend ActiveSupport::Concern

  included do
    layout 'me'
  end

  class_methods do
    def local_prefixes
      [controller_path, 'org/me/base']
    end
  end

end unless defined? OrgController::Me
