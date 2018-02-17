class CreateClientSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_sessions do |t|
      t.string :auth_token

      t.timestamps
    end
  end
end
