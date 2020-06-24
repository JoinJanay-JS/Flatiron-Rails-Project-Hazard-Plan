class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_schedule



  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @schedule.comment.new(params[:comment].permit(:reply, :schedule_id))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to schedule_path (@schedule), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  #def update
   # respond_to do |format|
    #  if @comment.update(comment_params)
     #   format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @comment }
      #else
       # format.html { render :edit }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
     # end
   # end
 # end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = @schedule.comments.find(params[:id])
    @comment.destroy
    redirect_to schedule_path (@schedule)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_schedule
      @schedule = Schedule.find(params[:schedule_id])
    end 

    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:schedule_id, :reply)
    end
end
