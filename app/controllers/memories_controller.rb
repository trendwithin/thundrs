class MemoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, only: [:update, :edit]

  def index
    @recent_memories = policy_scope(Memory).where.not(creator: current_user).order('created_at DESC').last(6)
  end

  def show
    # new comment for form helper
    @comment = Comment.new
    @related_memories = @memory.related_memories_sorted.first(5)
  end

  def edit
    authorize @memory
  end

  def new
    @memory = Memory.new
  end

  def create
    @memory = current_user.memories.build(memory_params)
    @memory.update_keyword_associations @memory.keywords

    if @memory.save
      redirect_to @memory, notice: 'Memory was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @memory

    @memory.update_keyword_associations memory_params[:keywords], @memory.keywords

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

  def set_memory
    @memory = Memory.find(params[:id])
  end

  def memory_params
    params.require(:memory).permit(:name, :keywords, :description, :creator_id, :image)
  end
end
