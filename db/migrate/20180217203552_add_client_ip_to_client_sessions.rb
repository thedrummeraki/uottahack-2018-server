class AddClientIpToClientSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :client_sessions, :client_ip, :string
  end
end
