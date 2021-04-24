class TestCasesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @test_cases = TestCase.all
    render json: @test_cases, status: :ok
  end

  def show
    @test_case = TestCase.find(params[:id])
    render json: { name: @test_case.name, scripts: @test_case.script }, status: :ok if @test_case
  end

  def create
    @test_case = TestCase.create(test_case_params)
    if @test_case.save
      @test_case.add_scripts(@test_case, params[:scripts])
      render json: @test_case, status: :ok
    else
      render json: @test_case.errors, status: unprocessable_entity
    end
  end

  private

  def test_case_params
    params.permit(:name)
  end
end
