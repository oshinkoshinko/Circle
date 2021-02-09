class Public::SearchesController < ApplicationController

  def index
    @q = Member.ransack(params[:q])
    @results = @q.result.(distinct: true)
    #@p = Event.ransack(params[:p])
    #@events = @p.result(distinct: true)
  end

  #def search
   # @q = Post.search(search_params)
    #@posts = @q.result(distinct: true)
    #@p = Event.search(search_params)
    #@events = @p.result(distinct: true)
  #end

  private

  def search_params
    params.require(:q).permit(:name)
  end

end
