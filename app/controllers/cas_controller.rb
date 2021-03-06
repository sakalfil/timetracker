class CasController < ApplicationController
  before_action :set_ca, only: [:show, :edit, :update, :destroy]
  before_action :set_predmet, only: [:index, :new, :edit, :create, :update]

  # GET /cas
  # GET /cas.json
  def index
    @cas = @predmet.cas.order("created_at DESC")
  end

  # GET /cas/1
  # GET /cas/1.json
  def show
  end

  # GET /cas/new
  def new
    @ca = Ca.new
  end

  # GET /cas/1/edit
  def edit
  end

  # POST /cas
  # POST /cas.json
  def create
    @ca = Ca.new(ca_params)
    @ca.predmet=@predmet
    @ca.trvanie=params[:ca][:trvanie]

    respond_to do |format|
      if @ca.save
        format.html { redirect_to predmet_cas_path(params[:predmet_id]), notice: 'Čas bol pridaný.' }
        format.json { render :show, status: :created, location: @ca }
      else
        format.html { render :new }
        format.json { render json: @ca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cas/1
  # PATCH/PUT /cas/1.json
  def update
    respond_to do |format|
      if @ca.update(ca_params)
        format.html { redirect_to predmet_cas_path(params[:predmet_id]), notice: 'Čas bol aktualizovaný.' }
        format.json { render :show, status: :ok, location: @ca }
      else
        format.html { render :edit }
        format.json { render json: @ca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cas/1
  # DELETE /cas/1.json
  def destroy
    @ca.destroy
    respond_to do |format|
      format.html { redirect_to predmet_cas_path(params[:predmet_id]), notice: 'Čas bol vymazaný.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ca
    @ca = Ca.find(params[:id])
  end
    
  def set_predmet
    @predmet=Predmet.find(params[:predmet_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ca_params
    params.require(:ca).permit(:trvanie, :text)
  end
end
