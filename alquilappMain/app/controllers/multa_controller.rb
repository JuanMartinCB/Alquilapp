class MultaController < ApplicationController
  before_action :set_multum, only: %i[ show edit update destroy ]

  # GET /multa or /multa.json
  def index
    if user_signed_in?
      @multa = Multum.where(user_id: current_user.id).order(created_at: :desc)
    else
      redirect_to root_path
    end
    #@multa = Multum.where(user_id: current_user.id)
  end

  # GET /multa/1 or /multa/1.json
  def show
  end

  # GET /multa/new
  def new
    @multum = Multum.new(:user_id => params[:id])
  end

  # GET /multa/1/edit
  def edit
  end

  # POST /multa or /multa.json
  def create
    @multum = Multum.new(multum_params)
    respond_to do |format|
      if @multum.save
        @w=Wtransaction.create(entry: (@multum.monto)*(-1), wallet_id: @multum.user.wallet.id, balance: @multum.user.wallet.balance, card_id: 1, wtype: "Multa", new_balance: @multum.user.wallet.balance - @multum.monto)
        Wallet.find(@multum.user.wallet.id).update_balance((@multum.monto)*(-1))
        #@multum.update_attributes(:supervisor_id => current_user.id) #testear esto
        Ticket.create(
          wtransaction_id: @w.id,
          user_id: current_user.id
        )
        format.html { redirect_to multum_url(@multum), notice: "Multum was successfully created." }
        format.json { render :show, status: :created, location: @multum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @multum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /multa/1 or /multa/1.json
  def update
    respond_to do |format|
      if @multum.update(multum_params)
        format.html { redirect_to multum_url(@multum), notice: "Multum was successfully updated." }
        format.json { render :show, status: :ok, location: @multum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @multum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /multa/1 or /multa/1.json
  def destroy
    @multum.destroy

    respond_to do |format|
      format.html { redirect_to multa_url, notice: "Multum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multum
      @multum = Multum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def multum_params
      params.require(:multum).permit(:monto, :razon, :user_id)
    end
end
