#define controller class with index def
class ProfileController < ApplicationController
  def index
    @user = User.find(params[:id])
  end
  #show method
  def show
    @user = User.find(params[:id])
  end

end