class ClientSession < ApplicationRecord

    has_secure_token :auth_token

    def is_used?
        self.session_used == true
    end

    def self.exists auth_token
        sessions = self.all
        sessions.select{|s| s.auth_token == auth_token}.size > 0
    end

    def self.create_new
        session = self.new
        session.regenerate_auth_token
        session.save ? session : nil
    end

    def self.get_all
        sessions = self.all
        sessions.each do |session|
            session.destroy unless session.is_used?
        end
        self.all
    end

end
