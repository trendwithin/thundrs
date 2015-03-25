class MemoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, only: [:update, :edit]
  # GET /memories
  # GET /memories.json
  def index
    @memories = policy_scope(Memory)
    @replies = current_user.replies.where(approved: false)
  end

  # GET /memories/1
  # GET /memories/1.json
  def show
    # new comment for form helper
    @comment = Comment.new
    @replies = @memory.comments.where(approved: true)
  end

  def edit
    authorize @memory
  end

  # GET /memories/new
  def new
    @memory = Memory.new
  end

  def create
    @memory = current_user.memories.build(memory_params)

    if @memory.save
      redirect_to @memory, notice: 'Memory was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @memory
    if @memory.update(memory_params)
      redirect_to @memory, notice: 'Memory was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_memory
    @memory = Memory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def memory_params
    params.require(:memory).permit(:name, :keywords, :description, :creator_id)
  end
end
