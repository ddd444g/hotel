class RoomsController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update, :new, :destroy]}
  def index
    @rooms = Room.all
    @user = User.find_by(id: session[:user_id])
  end

  def new
    @room = Room.new
    @user = User.find_by(id: session[:user_id])
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :introduction, :address, :price, :img,:user_id))
     if @room.save
      flash[:notice] = "お部屋を登録しました"
       redirect_to :rooms
     else
      @user = User.find_by(id: session[:user_id])
      render "users/show"
     end
  end

  def show
    @room = Room.find(params[:id])
    @user = User.find_by(id: session[:user_id])
  end

  def edit
    @room = Room.find(params[:id])
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(params.require(:room).permit(:name, :introduction, :address, :price, :img))
      flash[:notice] = "お部屋の情報を更新しました"
      redirect_to :rooms
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
     @room.destroy
     flash[:notice] = "お部屋を削除しました"
     redirect_to :rooms
  end
end
