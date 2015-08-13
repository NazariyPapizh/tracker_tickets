class AddColumnToTicketStatus < ActiveRecord::Migration
  def change
    add_column :ticket_statuses, :initiation, :boolean
  end
end
