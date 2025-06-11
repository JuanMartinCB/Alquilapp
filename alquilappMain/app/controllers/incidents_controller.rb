class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[ show edit update destroy ]

  # GET /incidents or /incidents.json
  def index
    @incidents = Incident.all
  end

  # GET /incidents/1 or /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    #allow the user to create an incident for a rental only if the diference between the rental start date and the current date is less than 10 minutes
    if (Time.now - Rental.find(params[:id]).created_at) < 600
      @incident = Incident.new( :rental_id => params[:id], :user_id => current_user.id, :vehicle_id => Rental.find(params[:id]).vehicle_id)
    else
      redirect_to rental_path(params[:id]), notice: "You can't create an incident for this rental."
    end
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents or /incidents.json
  def create
    @incident = Incident.new(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to incident_url(@incident), notice: "Incident was successfully created." }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1 or /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to incident_url(@incident), notice: "Incident was successfully updated." }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1 or /incidents/1.json
  def destroy
    @incident.destroy

    respond_to do |format|
      format.html { redirect_to incidents_url, notice: "Incident was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def asignar
    @incident = Incident.find(params[:id])
    @incident.update_attribute(:supervisor_id, current_user.id)
    redirect_to report_index_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def incident_params
      params.require(:incident).permit(:user_id, :vehicle_id, :description)
    end
end
