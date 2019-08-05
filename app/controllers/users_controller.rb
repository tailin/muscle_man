class UsersController < ApplicationController
  before_action :debug_info
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, only: [:line_login]
 
  def line_login
    if request.get?
      p params
      r = HTTParty.post("https://api.line.me/oauth2/v2.1/token",
        body:{
          grant_type: "authorization_code",
          code: params["code"],
          redirect_uri: "https://5d58b76d.ngrok.io/users/line_login",
          client_id: "1606444442",
          client_secret: "7391b1a072963d00bc4615859ca4d45b"
        }, headers: {"Content-Type": "application/x-www-form-urlencoded"})
        
        payload = JSON.parse(r.body)
        token = payload["id_token"]
        hmac_secret = params['state']
        decoded_token = JWT.decode(token, hmac_secret, nil, { algorithm: 'HS256' })
        u = decoded_token[0]
        User.find_or_create_by({email: u["email"], name: u["name"], picture: u["picture"], line_id: u["sub"]})
        redirect_to "https://line.me/R/ti/p/@880anerr"
    else
      redirect_to "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1606444442&redirect_uri=https://5d58b76d.ngrok.io/users/line_login&state=nostate&scope=profile%20openid%20email&nonce=123qwe"
    end
  end

  def auth;  end

  def index
    @users = User.all
  end

  def show;  end

  def new
    @user = User.new
  end

  def edit;  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @users = User.all
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        format.line { render :index }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@user.errors.to_s) }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        @users = User.all
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        format.line { render :index }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@todo.errors.to_s) }
      end
    end
  end

  def destroy
    @user.destroy
    @users = User.all
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
      format.line { render :index }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :name, :line_id, :picture)
    end

    def debug_info
      puts ""
      puts "=== kamigo debug info start ==="
      puts "platform_type: #{params[:platform_type]}"
      puts "source_type: #{params[:source_type]}"
      puts "source_group_id: #{params[:source_group_id]}"
      puts "source_user_id: #{params[:source_user_id]}"
      puts "=== kamigo debug info end ==="
      puts ""
    end
end
