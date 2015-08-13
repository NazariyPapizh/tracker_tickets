class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :full_body

      t.timestamps null: false
    end
  end
end
