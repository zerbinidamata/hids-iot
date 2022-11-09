class RulesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @rules = Rule.all
    render json: @rules, status: :ok
  end

  def show
    @rule = Rule.find(params[:id])
    if @rule
      render json: {
        rule: @rule,
        action_name: @rule.action.action_name,
        action_scripts: @rule.action.script,
        test_case_name: @rule.test_case.test_case_name,
        test_case_scripts: @rule.test_case.script
      }, status: :ok
    end
  end

  def create
    @rule = Rule.create(rules_params)
    if @rule.save
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
      @rule.add_actions(@rule, params[:actions])
      @rule.add_actions(@rule, params[:test_cases])
    else
      render json: @rule.errors, status: :unprocessable_entity
    end
  end

  def deliver_rule_to_group
    @rule = Rule.find(params[:id])
    @group = DeviceGroup.find(params[:group_id])
    rule_info = {
      rule: @rule,
      action_scripts: @rule.action.script,
      test_case_scripts: @rule.test_case.script
    }
    DeliveryBoy.deliver_async(rule_info.to_json, topic: "rules_group_#{@group.id}")
    render json: rule_info, status: :ok
  end

  private

  def rules_params
    params.permit(:name, :periodicity, :shared, :action_id, :test_case_id)
  end
end
