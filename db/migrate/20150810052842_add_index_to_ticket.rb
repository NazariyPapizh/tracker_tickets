class AddIndexToTicket < ActiveRecord::Migration
  def self.up
    add_index :tickets, :id
    add_index :tickets, :name
    add_index :tickets, :subject
    add_index :tickets, :full_body
    add_index :tickets, :u_reference

  end
  def self.down
    remove_index :tickets, :id
    remove_index :tickets, :name
    remove_index :tickets, :subject
    remove_index :tickets, :full_body
    remove_index :tickets, :u_reference
  end
end
