class Ticket < ActiveRecord::Base

  belongs_to :department
  belongs_to :ticket_status

  def get_ref
    self.u_reference
  end
  after_create :send_new_ticket_email

  private
  def send_new_ticket_email
    ref_url = get_ref
    name = self.name
    email = self.email
    NewTicketMailer.new_ticket_email(ref_url, name, email).deliver
  end

  before_create :generate_reference
  private
  def generate_reference
    a = ('A'..'Z').to_a
    h = ('A'..'F').to_a + (0..9).to_a
    af = -> () { (1..3).inject(''){ |sum, i| sum += a.sample } }
    hf = -> () { (1..2).inject(''){ |sum, i| sum += h.sample.to_s } }
    str = [af.call, hf.call, af.call, hf.call, af.call].join('-')
    self.u_reference = str
  end

  before_create :set_ticket_status

  private
  def set_ticket_status
    ts = TicketStatus.where(initiation: true).first
    self.ticket_status_id = ts.id
  end

  self.per_page = 10

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      :available_filters => %w[
                sorted_by
                search_query
                with_status
                with_department
                with_created_at_gte
              ]
  )

  scope :search_query, lambda { |query|
     return nil  if query.blank?
     terms = query.downcase.split(/\s+/)
     terms = terms.map { |e|
       (e.gsub('*', '%') + '%').gsub(/%+/, '%')
     }

     num_or_conditions = 4
     where(
         terms.map {
           or_clauses = [
               "LOWER(tickets.name) LIKE ?",
               "LOWER(tickets.subject) LIKE ?",
               "LOWER(tickets.full_body) LIKE ?",
               "LOWER(tickets.email) LIKE ?"
           ].join(' OR ')
           "(#{ or_clauses })"
         }.join(' AND '),
         *terms.map { |e| [e] * num_or_conditions }.flatten
     )

  }
  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
    case sort_key.to_s
      when /^created_at_/
        order("tickets.created_at #{ direction }")
      when /^name_/
        order("LOWER(tickets.name) #{ direction }")
      when /^ticket_status_name_/
        order("LOWER(ticket_status.name) #{ direction }").includes(:ticket_status)
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end

  }

  scope :with_department, lambda { |department|
    where(department_id: [*department])
  }

  scope :with_status, lambda { |status|
    where(ticket_status_id: [*status])
  }
  scope :with_created_at_gte, lambda { |ref_date|
    where('tickets.created_at >= ?', ref_date)
  }
  def self.options_for_sorted_by
    [
        ['Name (a-z)', 'name_asc'],
        ['Created date (newest first)', 'created_at_desc'],
        ['Created date (oldest first)', 'created_at_asc']
    ]
  end
end
