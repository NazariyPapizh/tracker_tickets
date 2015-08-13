class AddColumnsToTicket < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.references :ticket_status
      t.text :response
    end

  end
end
