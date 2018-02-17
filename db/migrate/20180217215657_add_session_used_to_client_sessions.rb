class AddSessionUsedToClientSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :client_sessions, :session_used, :boolean
  end
end
