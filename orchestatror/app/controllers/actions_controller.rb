class ActionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @actions = Action.all
    render json: @actions, status: :ok
  end

  def show
    @action = Action.find(params[:id])
    render json: { name: @action.name, scripts: @action.script }, status: :ok if @action
  end

  def create
    @action = Action.create(action_params)
    if @action.save
      @action.add_scripts(@action, params[:scripts])
      render json: @action, status: :ok
    else
      render json: @action.errors, status: unprocessable_entity
    end
  end

  private

  def action_params
    params.permit(:name)
  end
end
