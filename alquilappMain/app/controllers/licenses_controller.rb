class LicensesController < ApplicationController
  before_action :set_license, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /licenses or /licenses.json
  def index
    if current_user.supervisor?
      @licenses = License.all
    else
      redirect_to root_path, notice: 'No tiene permisos para ver licencias.'
    end
  end

  # GET /licenses/1 or /licenses/1.json
  def show
    #show licence belong to current user
    @license = License.where(user_id: current_user)
  end

  # GET /licenses/new
  def new
    if current_user.license.nil?
      @license = License.new
    else
      redirect_to root_path, notice: 'No tiene permisos para crear licencias.'
    end
  end

  # GET /licenses/1/edit
  def edit
    @license = License.find_by(user_id: current_user)
  end

  # POST /licenses or /licenses.json
  def create
    @license = License.new(license_params)

    respond_to do |format|
      if @license.save
        format.html { redirect_to license_url(@license), notice: "License was successfully created." }
        format.json { render :show, status: :created, location: @license }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenses/1 or /licenses/1.json
  def update
    respond_to do |format|
      if @license.update(license_params)
        format.html { redirect_to license_url(@license), notice: "License was successfully updated." }
        format.json { render :show, status: :ok, location: @license }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @license.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licenses/1 or /licenses/1.json
  def destroy
    @license = License.where(user_id: current_user)
    @license.destroy
    redirect_to root_path, notice: "Licencia eliminada con exito"
  end
  def authorize
    @license = License.find(params[:id])
    @license.update_attribute(:authorized,true)
    @license.update_attribute(:checked,true)
    redirect_to licenses_path, notice: "Licencia autorizada con exito"
  end
  def decline
    @license = License.find(params[:id])
    @license.update_attribute(:authorized,false)
    @license.update_attribute(:checked,true)
    redirect_to licenses_path, notice: "Licencia rechazada con exito"
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_license
      @license = License.where(user_id: current_user)
    end

    # Only allow a list of trusted parameters through.
    def license_params
      params.require(:license).permit(:user_id, :authorized, :checked, :image)
    end
end
