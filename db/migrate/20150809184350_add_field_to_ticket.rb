class AddFieldToTicket < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.references :department
    end
  end
end
