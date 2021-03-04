class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!,except: [:top]

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      if request.referer != nil
        redirect_to request.referer
      else
        redirect_to admin_genres_path
      end
    else
      @genres = Genre.all
      render 'index'
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    if request.referer != nil
      redirect_to request.referer
    else
      redirect_to admin_genres_path
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
