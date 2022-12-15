class BookingsController < ApplicationController
  def index
  end
  def new
  end

  def create
    @booking = Booking.new(params.require(:booking).permit(:start_date, :end_date, :total_people,:room_id,:user_id))
     if @booking.save
      flash[:notice] = "予約を登録しました"
       redirect_to :rooms
     else
      @user = User.find_by(id: session[:user_id])
      render "rooms/show"
     end  
  end

  def show
    @booking = Booking.find(params[:id])
    @user = User.find_by(id: session[:user_id])
  end

  def edit
    @booking = Booking.find(params[:id])
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(params.require(:booking).permit(:start_date, :end_date, :total_people,:room_id,:user_id))
      flash[:notice] = "予約の情報を更新しました"
      redirect_to :rooms
    else
      @user = User.find_by(id: session[:user_id])
      render "edit"
    end  
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = "予約を削除しました"
    redirect_to :rooms
  end
end
