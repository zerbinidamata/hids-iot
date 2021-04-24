class RulesController < ApplicationController
  def index
    @rules = Rule.all
  end

  def create
    @rule = Rule.create(rules_params[:name], rules_params[:periodicity], rules_params[:shared])
    if @rule.save?
      Rule.add_actions(@rule, rules_params[:actions])
      Rule.add_actions(@rule, rules_params[:test_cases])
    else
      # Raise error and log to logstash
    end
  end

  def update
    @rule = Rule.find(params[:id])
    @rule.update(rules_params[:name], rules_params[:periodicity], rules_params[:shared])
    if @rule.save?
      Rule.add_actions(@rule, rules_params[:actions])
      Rule.add_actions(@rule, rules_params[:test_cases])
    end
  end

  private

  def rules_params
    params.permit(:name, :periodicity, :shared, actions: [], test_cases: [])
  end
end
