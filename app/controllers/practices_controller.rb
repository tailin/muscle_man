class PracticesController < ApplicationController
  # before_action :debug_info
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:webhook]
  protect_from_forgery with: :null_session

  def webhook
      line ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
      reply_token = params["event"]["replyToken"]
      text = params["event"]["message"]["text"]

      case text
      when "recent_three_month"
        msg = "3"
      when "recent_six_month"
        msg = "6"
      when "recent_one_year"
        msg = "12"
      else
        msg = "error"
      end
      message = {
        type: 'text',
        text: msg
      }
      response = line.reply_message(reply_token, message)
      head :ok
  end

  def index
    # @practices = Practice.all.order("created_at DESC")
    @practices = Practice.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def show
  end

  def new
    @practice = Practice.new
  end
  
  def edit
  end

  def create
    @practice = Practice.new(practice_params)

    respond_to do |format|
      if @practice.save
        @practices = Practice.all
        format.html { redirect_to @practice, notice: 'Practice was successfully created.' }
        format.json { render :show, status: :created, location: @practice }
        format.line { render :index }
      else
        format.html { render :new }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@practice.errors.to_s) }
      end
    end
  end

  def update
    respond_to do |format|
      if @practice.update(practice_params)
        @practices = Practice.all
        format.html { redirect_to @practice, notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
        format.line { render :index }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@todo.errors.to_s) }
      end
    end
  end

  def destroy
    @practice.destroy
    @practices = Practice.all
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
      format.line { render :index }
    end
  end

  private
    def set_practice
      @practice = Practice.find(params[:id])
    end

    def practice_params
      params.require(:practice).permit(:bar_type, :moving, :amount, :unit, :rest, :weight)
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
