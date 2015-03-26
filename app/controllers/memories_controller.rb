class MemoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, only: [:update, :edit]
  # GET /memories
  # GET /memories.json
  def index
    memories = policy_scope(Memory)
    @recent_memories = memories.where.not(creator: current_user).order('created_at DESC').last(6)
    @personal_memories = memories.where(creator: current_user).order('created_at DESC')

    @replies = {}
    current_user.replies.where(approved: false).each do |reply|
      @replies[reply.memory] = [] unless @replies.keys.include? reply.memory
      @replies[reply.memory] << reply
    end
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

  def destroy
    authorize @memory
    @memory.destroy
    redirect_to memories_path, notice: 'Memory was successfully declined.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_memory
    @memory = Memory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def memory_params
    params.require(:memory).permit(:name, :keywords, :description, :creator_id, :image)
  end
end
