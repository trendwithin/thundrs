class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_memory, only: [:create, :update, :destroy]
  after_action :verify_authorized, only: [:update, :destroy]

  # POST /comments
  # POST /comments.json
  def create
    @comment = @memory.comments.build(comment_params)
    @comment.author = current_user
    @comment.approved = true if @memory.creator == current_user

    if @comment.save
      redirect_to @memory, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    authorize @comment
    if @comment.update(comment_params)
      redirect_to @memory, notice: 'Comment was successfully approved.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    authorize @comment
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully declined.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_memory
    @memory = Memory.find(params[:memory_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:body, :creator_id, :memory_id, :approved)
    # params.require(:comment).permit(*policy(@comment || Comment).permitted_attributes)
  end
end
