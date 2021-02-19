class Public::SearchesController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def index
    @q = Member.ransack(params[:q])
    @results = @q.result.(distinct: true)

  end

  private

  def search_params
    params.require(:q).permit(:name)
  end

end
