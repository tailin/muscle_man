class PracticesController < ApplicationController
  before_action :debug_info
  before_action :set_practice, only: [:show, :edit, :update, :destroy]

  # GET /practices
  # GET /practices.json
  def index
    @practices = Practice.all
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
  end

  # GET /practices/new
  def new
    @practice = Practice.new
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices
  # POST /practices.json
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

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
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

  # DELETE /practices/1
  # DELETE /practices/1.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params.require(:practice).permit(:bar_type, :moving, :amount, :unit, :rest)
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
