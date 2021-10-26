class DeviceGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @devices = DeviceGroup.all.to_json(include: %i[script device rule])
    render json: @devices, status: :ok
  end

  def show
    @group = DeviceGroup.find(params[:id]).to_json(include: %i[script device rule])
    if @group
      render json: @group, status: :ok
    else
      render json: { error: 'Device not found' }, status: 404
    end
  end

  def create
    @group = DeviceGroup.create(device_params)
    if @group.save
      @group.add_rules(@group, params[:rules])
      @group.add_scripts(@group, params[:scripts])
      DeliveryBoy.deliver_async(@group.rule.to_json, topic: "rules_group_#{@group.id}")
      render json: @group, status: :ok
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    @device = DeviceGroup.find(params[:id])
    @device.update(device_params)
    # Add option to remove scripts
    if params[:scripts]
      @device.add_scripts(@device, params[:scripts])
      render json: @device, status: :ok if @device.save
    else
      render json: @device.error, status: unprocessable_entity
    end
  end

  def send_rules
    @group = DeviceGroup.find(params[:id])
    @rule = Rule.find(@group.rule.first.id)
    rule_info = {
      rule: @group.rule,
      action_scripts: @rule.action.script,
      test_case_scripts: @rule.test_case.script  
    }
    DeliveryBoy.deliver_async(rule_info.to_json, topic: "rules_group_#{@group.id}")
    render json: rule_info, status: :ok  
  end

  private

  def device_params
    params.permit(:group_name, :scripts, :rules)
  end
end
