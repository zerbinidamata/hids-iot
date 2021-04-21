class TestCasesController < ApplicationController
  def index
    @test_cases = TestCase.all
  end

  def create
    @test_case = TestCase.create(test_case_params[:name])
    Script.add_scripts_relation(@test_case, test_case_params[:scripts]) if @test_case.save?
  end

  private

  def test_case_params
    params.permit(:name, scripts: [])
  end
end
