class PanelController < ApplicationController
    def index
      if current_user.admin_role? || current_user.supervisor_role?
        #show supervisor followed by admins at the top of the list and then active users 
        @users = User.where(supervisor_role: true).active.order(created_at: :desc) + User.where(admin_role: true).active.order(created_at: :desc) + User.where(user_role: true).active.all.order(created_at: :desc)
        #@users= User.all
      else
        redirect_to root_path
      end
    end

    #define a method to update user role from panel
    def update_role_supervisor
        @user = User.find(params[:id])
        @user.update_attribute(:supervisor_role, true)
        @user.update_attribute(:admin_role, false)
        @user.update_attribute(:user_role, false)
        redirect_to panel_index_path
    end
    def update_role_admin
        @user = User.find(params[:id])
        @user.update_attribute(:supervisor_role, false)
        @user.update_attribute(:admin_role, true)
        @user.update_attribute(:user_role, false)
        redirect_to panel_index_path
    end
    def update_role_user
        @user = User.find(params[:id])
        @user.update_attribute(:supervisor_role, false)
        @user.update_attribute(:admin_role, false)
        @user.update_attribute(:user_role, true)
        redirect_to panel_index_path
    end

    #def soft delete user to change state to 1. being 0 active and 1 soft deleted
    def soft_delete 
      @user = User.find(params[:id])
      @user.update(state: 1)
      if @user.supervisor?
        @aux = Incident.where(supervisor_id: @user.id)
        @aux.each do |i|
          i.update(supervisor_id: nil)
        end
      end
      redirect_to panel_index_path
    end


    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :phone, :cards, :dni, :license, :location_point)
    end    
end
