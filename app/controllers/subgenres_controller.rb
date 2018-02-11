class SubgenresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subgenre, only: [:show, :edit, :update, :destroy]

  # GET /subgenres
  # GET /subgenres.json
  # def reset
  #   $str = current_user.done
  #   $arr = $str.split('#')
  #   $arr.delete("")
  #   print $arr
  #   if $arr == nil
  #       redirect_to 'subgenres/#{params[:subgenre_id]}/questions'
  #       return
  #   else    
  #   $arr.each do |a|
  #   $usr = Question.find(a).first
         
  #     if $usr.subgenre == params[:subgenre_id]
  #       $arr.delete(a)
  #     end
  #   end 
  #   end   
  # current_user.done = $arr.join('#')
  # current_user.save
  # redirect_to 'subgenres/#{params[:subgenre_id]}/questions'

  # end  
  def reset
    current_user.done=""
    t = Tracker.where(user_id: current_user.id)
    t.each do |i|
      i.score=0
      i.save
    end
    current_user.save
    redirect_to root_path
  end

  def index
    set_genre
    @subgenres = @genre.subgenres.all
  end
  #   if current_user.admin==true
  #     set_genre
  #     @subgenres = @genre.subgenres.all
  #   else
  #     redirect_to root_path
  #   end
  # end

  # GET /subgenres/1
  # GET /subgenres/1.json
  def show
  end

  # GET /subgenres/new
  def new
    if current_user.admin==true
      @subgenre = Subgenre.new
    else
      redirect_to root_path
    end
  end

  # GET /subgenres/1/edit
  def edit
    if current_user.admin==true
    else
      redirect_to root_path
    end

  end

  # POST /subgenres
  # POST /subgenres.json
  def create
    @subgenre = Subgenre.new(subgenre_params)

    respond_to do |format|
      if @subgenre.save
        format.html { redirect_to @subgenre, notice: 'Subgenre was successfully created.' }
        format.json { render :show, status: :created, location: @subgenre }
      else
        format.html { render :new }
        format.json { render json: @subgenre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subgenres/1
  # PATCH/PUT /subgenres/1.json
  def update
    respond_to do |format|
      if @subgenre.update(subgenre_params)
        format.html { redirect_to @subgenre, notice: 'Subgenre was successfully updated.' }
        format.json { render :show, status: :ok, location: @subgenre }
      else
        format.html { render :edit }
        format.json { render json: @subgenre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subgenres/1
  # DELETE /subgenres/1.json
  def destroy
    @subgenre.destroy
    respond_to do |format|
      format.html { redirect_to subgenres_url, notice: 'Subgenre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subgenre
      @subgenre = Subgenre.find(params[:id])
    end

    def set_genre
      @genre = Genre.find(params[:genre_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subgenre_params
      params.require(:subgenre).permit(:title, :genre_id)
    end
end
