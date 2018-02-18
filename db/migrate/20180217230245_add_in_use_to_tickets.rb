class AddInUseToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :in_use, :boolean
  end
end
