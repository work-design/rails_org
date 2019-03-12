module ApplicationCable
  class Channel < ActionCable::Channel::Base


    def unsubscribed
      logger.debug '----- away ----'
    end


  end
end
