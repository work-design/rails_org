module Org
  module Layout::Panel
    extend ActiveSupport::Concern

    included do
      layout 'panel'
    end

    class_methods do
      def local_prefixes
        [controller_path, 'org/panel/base', 'panel']
      end
    end

  end
end
