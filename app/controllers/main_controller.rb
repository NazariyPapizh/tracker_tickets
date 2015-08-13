class MainController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  layout "admin", only: "admin"
  def index
    @ticket = Ticket.new
    @tickets = Ticket.all
  end

  def admin
    # render layout: "admin"
  end

end
