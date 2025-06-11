class RentalsController < ApplicationController
  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1 or /rentals/1.json
  def show
    @rental = Rental.find(params[:id])
  end

  #define a new show method to show the las active rental to current user
  def show2
    @rental = Rental.where(user_id: current_user.id).last
  end

  # GET /rentals/new
  def new
    @rental = Rental.new( :vehicle_id => params[:id], :user_id => current_user.id)
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals or /rentals.json
  def create
    @rental = Rental.new(rental_params)
    respond_to do |format|
      if @rental.save
        Vehicle.find(@rental.vehicle_id).use!
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully created." }
        format.json { render :show, status: :created, location: @rental }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
  def update
    #@rental.update_hours(@rental.hours + @rental.hours)
    
    respond_to do |format|
      if @rental.update(rental_params)
        #update hours with the actual hours and the hours from form
        # @rental.update_hours(@rental.hours + @rental.hours)
        format.html { redirect_to rental_url(@rental), notice: "Rental was successfully updated." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy

    respond_to do |format|
      format.html { redirect_to rentals_url, notice: "Rental was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  # #create a post method for the extendeed hours
  # def extend_hours
  #   @rental = Rental.find(params[:id])
  #   Wtransaction.create(
  #     entry: -(@rental.range_hours * 200), 
  #     wallet_id: Wallet.find(@rental.user_id).id, 
  #     new_balance: Wallet.find(@rental.user_id).balance, 
  #     card_id: 1, wtype: "Alquiler Extendido", 
  #     new_balance: Wallet.find(@rental.user_id).balance - (@rental.range_hours * 200))
  #   Wallet.find(@rental.user_id).update_balance(-(@rental.hours * 200))
  #   redirect_to rental_path(@rental)
  # end

  #crate finish rental method
  def finish
    @rental = Rental.find(params[:id])
    @rental.finish!
    @rental.update_attribute(:finish_at, Time.now)
    if Time.now > @rental.created_at + (@rental.hours*60*60)
      #convert the add of created_at and hours to minutes
      @rental.update_attribute(:extra_cost, @rental.created_at + ((Time.now - (@rental.created_at + (@rental.hours*60*60)))/60).round)
    else
      @rental.update_attribute(:extra_cost, 0)
    end
    @w=Wtransaction.create(
      wallet_id: Wallet.find_by(user_id: @rental.user_id).id,
      card_id: nil,
      wtype: "Alquiler",
      entry: -((@rental.hours * 200)+(@rental.extra_cost/10 * 150)),
      new_balance: Wallet.find_by(user_id: @rental.user_id).balance - (@rental.hours * 200)+(@rental.extra_cost/10 * 150),
      balance: Wallet.find_by(user_id: @rental.user_id).balance
    )
    Wallet.find_by(user_id: @rental.user_id).update_balance(-((@rental.hours * 200)+(@rental.extra_cost/10 * 150)))

    #create a cooldown for the user
    Cooldown.create(user_id: @rental.user_id, vehicle_id: @rental.vehicle_id)
    Vehicle.find(@rental.vehicle_id).use!
    Ticket.create(wtransaction_id: @w.id, rental_id: @rental.id, user_id: current_user.id)
    redirect_to root_path
  end

  #def the overlimit method for rental
  def overlimit
    @rental = Rental.find(params[:id])
    @rental.overlimit!
    redirect_to rentals_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_params
      params.require(:rental).permit(:user_id, :vehicle_id, :start_point, :end_point, :state, :finish_at, :hours)
    end
end
