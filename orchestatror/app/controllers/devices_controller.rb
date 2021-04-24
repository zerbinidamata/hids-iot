class DevicesController < ApplicationController
  def index
    @devices = Devices.all
    render json: @devices, status: :ok
  end

  def show
    @device = Device.find(params[:device_id])
    scripts = @device.scripts
    if @device
      render json: { device: @device, scripts: scripts }, status: :ok
    else
      render json: { error: 'Device not found' }, status: 404
    end
  end
end
