class ScriptsController < ApplicationController
  def index
    @scripts = Scripts.all
  end

  # TODO: add upload of file in storage as well
  def create
    @script = Script.create(script_params)
  end

  private

  def script_params
    params.permit(:name, :uri)
  end
end
