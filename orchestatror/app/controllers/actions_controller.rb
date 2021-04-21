class ActionsController < ApplicationController
  def index
    @actions = Action.all
  end

  def create
    @action = Action.create(action_params[:name])
    Script.add_scripts_relation(@action, action_params[:scripts]) if @action.save?
  end

  private

  def action_params
    params.permit(:name, scripts: [])
  end
end
