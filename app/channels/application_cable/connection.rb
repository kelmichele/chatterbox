module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_or_guest_user

    def connect
      self.current_or_guest_user = find_verified_user
    end

    protected

    def find_verified_user
      if (current_or_guest_user = env['warden'].user)
        current_or_guest_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
