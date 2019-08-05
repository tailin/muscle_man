class PracticesController < ApplicationController
  before_action :debug_info
  before_action :set_practice, only: [:show, :edit, :update, :destroy]
  before_action :today_practice, only:[:index, :create, :update, :destroy]
  def index
    # @test = Practice.select(:bar_type, :moving).distinct
  end

  def search
    if request.get?
      p "--------------"
      p params
      p "--------------"
      @search = []
      Practice.select(:bar_type, :moving).where(line_id: params[:source_user_id]).distinct.each_with_index do |select, idx| 
        @search.push ["#{select.bar_type}#{select.moving}", idx]
      end
      p @search
    else
      m = params[:month].to_i
      t = params[:traning].to_i
      line_id = params[:source_user_id]
      p "============================"
      p params
      p "============================"
      list = Practice.select(:bar_type, :moving).where(line_id: line_id).distinct[t]
      @practices = Practice.where("line_id = ? AND bar_type = ? AND moving = ? AND created_at >= ?", line_id, list.bar_type, list.moving, Time.now - m.months)
      p @practices
      respond_to do |format|
          format.html { redirect_to @practices, notice: 'Practice was successfully created.' }
          format.json { render :show, status: :created, location: @practices }
          format.line { render :search }
      end
    end
  end

  def show;  end

  def new
    @practice = Practice.new
  end
  
  def edit;  end

  def create
    @practice = Practice.new(practice_params)

    respond_to do |format|
      if @practice.save
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
        format.html { redirect_to @practice, notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
        format.line { render :index }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
        format.line { render json: flex_text(@practice.errors.to_s) }
      end
    end
  end

  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
      format.line { render :index }
    end
  end

  private
    def today_practice
      @practices = Practice.where(line_id: params[:source_user_id], created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).order("created_at DESC")
    end

    def set_practice
      @practice = Practice.find(params[:id])
    end

    def practice_params
      params.require(:practice).permit(:bar_type, :moving, :amount, :unit, :rest, :weight, :line_id)
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
