class ClientSession < ApplicationRecord

    has_secure_token :auth_token

    def self.exists auth_token
        sessions = self.get_all
        sessions.select{|s| s.auth_token == auth_token}.size > 0
    end

    def self.create_or_get client_ip
        session = self.find_by client_ip: client_ip
        return session unless session.nil?
        session = self.new client_ip: client_ip
        session.regenerate_auth_token
        session
    end

    def self.get_all
        sessions = self.all
        sessions.each do |session|
            session.destroy if session.auth_token.nil?
        end
        self.all
    end

end
