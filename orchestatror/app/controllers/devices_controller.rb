class DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @devices = Device.all.to_json(include: :device_group)
    render json: @devices, status: :ok
  end

  def show
    @device = Device.find(params[:id])
    if @device
      render json: { device: @device, scripts: scripts }, status: :ok
    else
      render json: { error: 'Device not found' }, status: 404
    end
  end

  def create
    @device = Device.create(device_params)
    if @device.save
      render json: @device, status: :ok
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  def update
    @device = Device.find(params[:id])
    @device.update(device_params)
    if @device.save
      render json: @device, status: :ok
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.permit(:device_ip, :device_group_id)
  end
end
