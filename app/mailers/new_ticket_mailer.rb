class NewTicketMailer < ApplicationMailer
  default_url_options[:host] = 'localhost'
  def new_ticket_email(ref_url, name, email)
    @ref = ref_url
    @name = name
    @email = email
    mail(:to => 'nazariy.papizh@gmail.com',
         :template_path => 'mailer_templates', :template_name => 'new_ticket_email',
         :subject => "Welcome to My Awesome Site")
  end

  def response_on_ticket(message)
    @msg = message
    mail(:to => 'nazariy.papizh@gmail.com',
         :template_path => 'mailer_templates', :template_name => 'response_on_ticket',
         :subject => "Response on your ticker")
  end
end
