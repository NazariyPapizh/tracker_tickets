class TicketStatus < ActiveRecord::Base
  has_many :tickets

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
