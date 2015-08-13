class TicketStatusesController < ApplicationController
  before_action :set_ticket_status, only: [:show, :edit, :update, :destroy]
  layout "admin"

  # GET /ticket_statuses
  # GET /ticket_statuses.json
  def index
    @ticket_statuses = TicketStatus.all
  end

  # GET /ticket_statuses/1
  # GET /ticket_statuses/1.json
  def show
  end

  # GET /ticket_statuses/new
  def new
    @ticket_status = TicketStatus.new
  end

  # GET /ticket_statuses/1/edit
  def edit
  end

  # POST /ticket_statuses
  # POST /ticket_statuses.json
  def create
    @ticket_status = TicketStatus.new(ticket_status_params)

    respond_to do |format|
      if @ticket_status.save
        format.html { redirect_to @ticket_status, notice: 'Ticket status was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_status }
      else
        format.html { render :new }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_statuses/1
  # PATCH/PUT /ticket_statuses/1.json
  def update
    respond_to do |format|
      if @ticket_status.update(ticket_status_params)
        format.html { redirect_to @ticket_status, notice: 'Ticket status was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_status }
      else
        format.html { render :edit }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_statuses/1
  # DELETE /ticket_statuses/1.json
  def destroy
    @ticket_status.destroy
    respond_to do |format|
      format.html { redirect_to ticket_statuses_url, notice: 'Ticket status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_status
      @ticket_status = TicketStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_status_params
      params.require(:ticket_status).permit(:name, :initiation)
    end
end
