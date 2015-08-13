class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  layout "admin"
  before_action :authenticate_user!, only: [:index]

  require 'will_paginate'


  # GET /tickets
  # GET /tickets.json
  def preview
    @your_ticket = Ticket.find_by_u_reference(params[:u_reference])
    render layout: "application"
  end

  def index

    @filterrific = initialize_filterrific(
        Ticket,
        params[:filterrific],
        select_options: {
            sorted_by: Ticket.options_for_sorted_by,
            with_status: TicketStatus.options_for_select,
            with_department: Department.options_for_select
        }
    ) or return
    @tickets = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save

        format.html { redirect_to root_path, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        if @ticket.response.present?
          NewTicketMailer.response_on_ticket(@ticket.response).deliver
        end
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :email, :subject, :full_body, :u_reference, :department_id, :ticket_status_id, :response)
    end
end
