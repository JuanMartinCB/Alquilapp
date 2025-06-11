class VehiclesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  

  # GET /vehicles or /vehicles.json
  def index
    @search = params["search"]
    if user_signed_in?
      if current_user.admin? || current_user.supervisor?
        @vehicles = Vehicle.all
        if @search.present?
          @brand = @search["brand"]
          @model = @search["model"]
          @vehicle_type = @search["vehicle_type"]
          @vehicles = Vehicle.where("brand ILIKE ? AND model ILIKE ? AND vehicle_type ILIKE ?", "%#{@brand}%", "%#{@model}%", "%#{@vehicle_type}%")
        end       
      else
        if session[:lat].present? && session[:lng].present?
          @c = Cooldown.where(user_id: current_user.id).where("created_at > ?", 3.hours.ago)
          #assign @vehciles all vehicles where id not in @c
          @vehicles = Vehicle.published.where.not(id: @c.pluck(:vehicle_id)).order(Arel.sql("point(#{session[:lat]}, #{session[:lng]}) <-> location"))
          if @search.present?
            @brand = @search["brand"]
            @model = @search["model"]
            @vehicle_type = @search["vehicle_type"]
            @vehicles = Vehicle.where("brand ILIKE ? AND model ILIKE ? AND vehicle_type ILIKE ?", "%#{@brand}%", "%#{@model}%", "%#{@vehicle_type}%").published.where.not(id: @c.pluck(:vehicle_id)).order(Arel.sql("point(#{session[:lat]}, #{session[:lng]}) <-> location"))
          end
        else
          @c = Cooldown.where(user_id: current_user.id).where("created_at > ?", 3.hours.ago)
          @vehicles = Vehicle.published.where.not(id: @c.pluck(:vehicle_id))          
          if @search.present?
            @brand = @search["brand"]
            @model = @search["model"]
            @vehicle_type = @search["vehicle_type"]
            @vehicles = Vehicle.where("brand ILIKE ? AND model ILIKE ? AND vehicle_type ILIKE ?", "%#{@brand}%", "%#{@model}%", "%#{@vehicle_type}%").published.where.not(id: @c.pluck(:vehicle_id))
          end
        end
      end
    else
        @vehicles = Vehicle.published
        if @search.present?
          @brand = @search["brand"]
          @model = @search["model"]
          @vehicle_type = @search["vehicle_type"]
          @vehicles = Vehicle.where("brand ILIKE ? AND model ILIKE ? AND vehicle_type ILIKE ?", "%#{@brand}%", "%#{@model}%", "%#{@vehicle_type}%").published          
        end
    end
    # @search = params["search"]
    #     if @search.present?
    #       @brand = @search["brand"]
    #       @model = @search["model"]
    #       @vehicle_type = @search["vehicle_type"]
    #       @vehicles = Vehicle.where("brand ILIKE ? AND model ILIKE ? AND vehicle_type ILIKE ?", "%#{@brand}%", "%#{@model}%", "%#{@vehicle_type}%")          
    #     end
  end 
  # GET /vehicles/1 or /vehicles/1.json
  def show
    if Vehicle.exists?(params[:id])
      @vehicle = Vehicle.find(params[:id])
    else
      redirect_to vehicles_path, notice: "El vehiculo no existe"
    end
  end
  
  def publish
    @vehicle = Vehicle.find(params[:id])
    #create postgresql point 
    @vehicle.update_attribute(:location, [session[:lat], session[:lng]])
    @vehicle.publish!
    redirect_to vehicle_url(@vehicle), notice: 'Publicado con Exito!.'
  end

  def block 
    @vehicle = Vehicle.find(params[:id])
    @vehicle.block!
    redirect_to vehicle_url(@vehicle), notice: 'Bloqueado con Exito!.'
  end

  def rent
    @vehicle = Vehicle.find(params[:id])
    @vehicle.in_use!
    @rental = Rental.new 
  end

  # GET /vehicles/new
  def new
    if current_user.admin?
      @vehicle = Vehicle.new 
    else
      redirect_to vehicles_path, notice: 'No tiene permisos para crear vehiculos.'
    end
  end

  # GET /vehicles/1/edit
  def edit
    if current_user.admin?
      @vehicle = Vehicle.find(params[:id])
    else
      redirect_to vehicles_path, notice: 'No tiene permisos para editar vehiculos.'
    end
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)
    
    
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to vehicle_url(@vehicle), notice: 'Vehicle was successfully created.' }
        format.json { render :show, status: :created, location: @vehicle }
        @vehicle.update_attribute(:location, [session[:lat], session[:lng]])
        @vehicle.patent = @vehicle.patent.upcase 
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      redirect_to vehicle_url(@vehicle), notice: 'Vehicle was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    redirect_to vehicles_path
  end

  private

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:did, :brand, :model, :year, :vehicle_type, :patent, :location, :image, :state, features:[])
    end
end
