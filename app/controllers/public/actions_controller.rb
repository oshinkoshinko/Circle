class Public::ActionsController < ApplicationController

  def create
    #binding.pry
    @action = Action.new(action_params)
    @action.member_id = current_member.id
    @action.save
    redirect_to request.referer
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def action_params
    params.require(:action).permit(:body)
  end

end
