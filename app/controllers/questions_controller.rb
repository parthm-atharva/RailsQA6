class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answers = Question.find_by(id: params[:id]).answers
    @answer = Question.find_by(id: params[:id]).answers.new
  end

  # GET /questions/new
  def new
    @question = current_user.questions.new
    @topics = current_user.topics
  end

  # GET /questions/1/edit
  def edit
    @topics = current_user.topics
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = current_user.questions.new(question_params)

    respond_to do |format|
      if @question.save
        @question.associate_topic(params[:question][:topic])
        format.html { redirect_to root_path, notice: 'Question was successfully created.' }
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
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to root_path, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
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

  def post_answer
    question = Question.find_by(id: params[:id])
    respond_to do |format|
      if question
        answer = question.answers.new(answer_params)
        answer.user_id = current_user.id
        answer.save
        format.html { redirect_to question, notice: 'Answer was successfully submitted.' }
        format.json { render :show, status: :ok, location: question }
      else
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title)
    end

    def answer_params
      params.require(:answer).permit(:description)
    end
end
