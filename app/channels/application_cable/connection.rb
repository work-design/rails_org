module ApplicationCable
  class Connection < ActionCable::Connection::Base
    prepend RailsNoticeConnection
    prepend RailsDataConnection

    def connect
      logger.debug '-----> receiver info'
      logger.debug "#{current_receiver.class}:#{current_receiver&.id}"
      logger.debug '----->'
    end

  end
end
