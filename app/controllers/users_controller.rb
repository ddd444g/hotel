class UsersController < ApplicationController
# ログインしてないユーザーのアクセス制限
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
# ログイン中のアクセス制限
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
# ログイン中しか編集出来ないようにする
  before_action :ensure_correct_user, {only: [:edit, :update]}
  def index
    @users = User.all
    @rooms = Room.all
    @bookings = Booking.all
    @user = User.find_by(id: session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :profile, :email,:password, :icon))
     if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを新規登録しました"
       redirect_to :rooms
     else
       render "new"
     end
  end

  def show
    @user = User.find_by(id: params[:id])
    @room = Room.find_by(id: params[:id])
    @room = Room.new
    @rooms = @user.rooms
    @bookings = @user.bookings
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :profile, :email,:password, :icon))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to :rooms
    else
      render "edit"
    end  
  end

  def destroy
     @user = User.find(params[:id])
     @user.destroy
     flash[:notice] = "ユーザーを削除しました"
     redirect_to ("/users/#{@user.id}/show")
  end

  def login_form
    
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/rooms")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end 
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/rooms/index")
    end
  end  
end
