class AddColumnToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :u_reference, :string
  end
end
