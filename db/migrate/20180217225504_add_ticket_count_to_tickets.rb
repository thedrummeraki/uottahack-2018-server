class AddTicketCountToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :ticket_count, :integer
  end
end
