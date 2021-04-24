include Rails.application.routes.url_helpers
class ScriptsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @scripts = Script.all
    render json: @scripts, status: :ok
  end

  def show
    @script = Script.find(params[:id])
    if @script
      render json: { script: { name: @script.name, uri: rails_blob_url(@script.file) } }, status: :ok
    else
      render json: @script.errors, status: :unprocessable_entity
    end
  end

  # TODO: add upload of file in storage as well
  def create
    @script = Script.create(script_params)
    if @script.save
      render json: @script, status: :ok
    else
      render json: @script.errors, status: :unprocessable_entity
    end
  end

  def update
    @script = Script.find(params[:id])
    if @script && script_params[:file]
      @script.file.attach(script_params[:file])
      render json: @script, status: :ok
    else
      render json: @script.errors, status: :unprocessable_entity
    end
  end

  private

  def script_params
    params.permit(:name, :file, :id)
  end
end
