class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create, :destroy]

  def new
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    @bookmark = @list.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to @list, notice: 'Le bookmark a été ajouté avec succès.'
    else
      render :new
    end
  end

  def destroy
    @bookmark = @list.bookmarks.fond(params[:id])
    @bookmark.destroy
    redirect_to @list, status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])  # Associe la bonne liste
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)  # Assure que les bons params sont permis
  end
end
