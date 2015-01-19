class BeCombinesController < ApplicationController
  before_action :set_be_combine, only: [:show, :edit, :update, :destroy]

  # GET /be_combines
  # GET /be_combines.json
  def index
    @be_combines = BeCombine.all
  end

  # GET /be_combines/1
  # GET /be_combines/1.json
  def show
  end

  # GET /be_combines/new
  def new
    @be_combine = BeCombine.new
  end

  # GET /be_combines/1/edit
  def edit
  end

  # POST /be_combines
  # POST /be_combines.json
  def create
    @be_combine = BeCombine.new(be_combine_params)

    respond_to do |format|
      if @be_combine.save
        format.html { redirect_to @be_combine, notice: 'Be combine was successfully created.' }
        format.json { render :show, status: :created, location: @be_combine }
      else
        format.html { render :new }
        format.json { render json: @be_combine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /be_combines/1
  # PATCH/PUT /be_combines/1.json
  def update
    respond_to do |format|
      if @be_combine.update(be_combine_params)
        format.html { redirect_to @be_combine, notice: 'Be combine was successfully updated.' }
        format.json { render :show, status: :ok, location: @be_combine }
      else
        format.html { render :edit }
        format.json { render json: @be_combine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /be_combines/1
  # DELETE /be_combines/1.json
  def destroy
    @be_combine.destroy
    respond_to do |format|
      format.html { redirect_to be_combines_url, notice: 'Be combine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_be_combine
      @be_combine = BeCombine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def be_combine_params
      params.require(:be_combine).permit(:name, :link, :start_year, :end_year, :techspec)
    end
end
