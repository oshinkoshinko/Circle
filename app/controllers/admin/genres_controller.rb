class Admin::GenresController < ApplicationController

  def index
  end

  def create
  end

  def destroy
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

end
