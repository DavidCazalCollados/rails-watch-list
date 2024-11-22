class ListsController < ApplicationController
  def index
    @lists = List.all
    @lists_with_first_movie = @lists.map do |list|
      first_movie = list.bookmarks.first&.movie
      { list: list, first_movie: first_movie }
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
