class WtransactionsController < ApplicationController
  before_action :set_wtransaction, only: %i[ show edit update destroy ]

  # GET /wtransactions or /wtransactions.json
  def index
    @wtransactions = Wtransaction.all
  end

  # GET /wtransactions/1 or /wtransactions/1.json
  def show
  end

  # GET /wtransactions/new
  def new
    
    @wtransaction = Wtransaction.new(card_id: params[:id])
  end
  

  # GET /wtransactions/1/edit
  def edit
  end

  # POST /wtransactions or /wtransactions.json
  def create
    @wtransaction = Wtransaction.new(wtransaction_params)
    respond_to do |format|
      if @wtransaction.save
        @wtransaction.wallet.update_balance(@wtransaction.entry) 
        @wtransaction.update_attribute(:new_balance, @wtransaction.wallet.balance)
        Ticket.create(
          wtransaction_id: @wtransaction.id,
          user_id: current_user.id
        )
        # #update tiket_id in wtransaction
        # @wtransaction.update_attribute(:ticket_id, @ticket.id)
        format.html { redirect_to wallet_path(current_user.id), notice: "Wtransaction was successfully created." }
        format.json { render :show, status: :created, location: @wtransaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wtransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wtransactions/1 or /wtransactions/1.json
  def update
    respond_to do |format|
      if @wtransaction.update(wtransaction_params)
        format.html { redirect_to wtransaction_url(@wtransaction), notice: "Wtransaction was successfully updated." }
        format.json { render :show, status: :ok, location: @wtransaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wtransaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wtransactions/1 or /wtransactions/1.json
  def destroy
    @wtransaction.destroy

    respond_to do |format|
      format.html { redirect_to wtransactions_url, notice: "Wtransaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wtransaction
      @wtransaction = Wtransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wtransaction_params
      params.require(:wtransaction).permit(:wallet_id, :card_id, :balance, :entry, :new_balance, :integer, :wtype, :cvc)
    end
end
