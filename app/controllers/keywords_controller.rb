class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def show
    @keyword = Keyword.find(params[:id])
    @memories = @keyword.memories
  end
end
