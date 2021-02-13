class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!,except: [:top]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to request.referer
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to request.referer
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
