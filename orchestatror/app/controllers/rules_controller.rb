class RulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @rules = Rule.all
    render json: @rules, status: :ok
  end

  def show
    @rule = Rule.find(params[:id])
    render json: { name: @rule.name, actions: @rule.action, test_cases: @rule.test_case }, status: :ok if @rule
  end

  def create
    @rule = Rule.create(rules_params)
    if @rule.save
      @rule.add_actions(@rule, params[:actions])
      @rule.add_actions(@rule, params[:test_cases])
      render json: @rule, status: :ok
    else
      # Raise error and log to logstash
      render json: @rule.errors, status: :unprocessable_entity
    end
  end

  def update
    @rule = Rule.find(params[:id])
    @rule.update(rules_params)
    if @rule.save
      Rule.add_actions(@rule, params[:actions])
      Rule.add_actions(@rule, params[:test_cases])
    else
      render json: @rule.errors, status: :unprocessable_entity
    end
  end

  private

  def rules_params
    params.permit(:name, :periodicity, :shared)
  end
end
