class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate,            except: [:new, :create]
  before_action :load_user,               except: [:index, :new, :create]
  before_action :authorize_user,     only: :show

  # GET /users
  # GET /users.json
  def index
    current_user = session[:user_id]
    respond_to do |format|
      format.json { render :json => current_user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @photos = Photo.where(user_id: session[:user_id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.save

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :dob, :password, :password_confirmation)
    end

    def user_password_params
    @user_password_params ||= params.require(:user).permit(
      :old_password,
      :password,
      :password_confirmation
    )
  end

  def load_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path if !@user
  end

  def authorize_admin_only
    unless current_user.is_admin?
      redirect_to user_path(current_user)
    end
  end

  def authorize_user
    unless current_user == @user
      redirect_to user_path(current_user)
    end
  end

end
