class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    set_subgenre
    @questions = @subgenre.questions.all
  end
  #   if current_user.admin==true
  #     set_subgenre
  #     @questions = @subgenre.questions.all
  #   else
  #     redirect_to root_path
  #   end
  # end

  # GET /questions/1
  # GET /questions/1.json
  def show
    if not(current_user.done.nil?)
      a = current_user.done.split('#')
      b = ''
      b << @question.id
      if a.include? b 
          redirect_to '/subgenres/'+(@question.subgenre.id).to_s+'/questions/'
      end
    end
  end

  # GET /questions/new
  def new
    if current_user.admin==true
      @question = Question.new    
    else
      redirect_to root_path
    end
  end

  # GET /questions/1/edit
  def edit
    if current_user.admin==true
    else
      redirect_to root_path
    end

  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if current_user.done.nil?
      current_user.done = '#'
    end

    current_user.done << (@question).id
    current_user.done << '#'
    current_user.save
    a=''
    if(params[:A])
      a+='Op1'
      print("ok1\n\n\n")
    end
    if(params[:B])
      a+='Op2'
      print("ok2\n\n\n")
    end
    if(params[:C])
      a+='Op3'
      print("ok3\n\n\n")
    end
    if(params[:D])
      a+='Op4'
      print("ok4\n\n\n")
    end
    if a == @question.answer
      @var = Tracker.all
      @var.each do |var|
        print(var.to_s)
        if var.user_id == current_user.id
          if var.subgenre_id == @question.subgenre.id
            print("ans sahi he bc\n\n\n")
            var.score += 10
            var.save
          end
        end
      end
      print("yes")
      redirect_to '/subgenres/'+(@question.subgenre.id).to_s+'/questions/'
    else
      print("no\n\n\n\n")
      redirect_to '/subgenres/'+(@question.subgenre.id).to_s+'/questions/'
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_subgenre
      @subgenre = Subgenre.find(params[:subgenre_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:text, :op1, :op2, :op3, :op4, :answer, :subgenre_id)
    end
end
