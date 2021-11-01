class ExternalAgentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: {name: 'External agent 1', policy_name: 'restricted', api_key: '13e6bf519e19cd12f77f349f82ec2db4', api_secret: '04d65316a97dff7580060516cb88b496' }

      # render json: ExternalAgent.all, status: :ok
  end

  def show
    render json: {name: 'External agent 1', policy_name: 'restricted', api_key: '13e6bf519e19cd12f77f349f82ec2db4', api_secret: '04d65316a97dff7580060516cb88b496' }

    @agent = ExternalAgent.find(params[:id])
    if @agent
      render json: { agent: @agent, scripts: scripts }, status: :ok
    else
      render json: { error: 'Agent not found' }, status: 404
    end
  end

  def create
    render json: { name: 'External agent 1', policy_name: 'restricted', api_key: '13e6bf519e19cd12f77f349f82ec2db4', api_secret: '04d65316a97dff7580060516cb88b496', psk: '47BCE5C74F589F4867DBD57E9CA9F808' }
    # @agent = ExternalAgent.new(params)
    # # @agent = ExternalAgent.new(agent_params.merge({ 
    # #   api_key: SecureRandom.hex(16),
    # #   api_secret: SecureRandom.hex(16) }))
    # if @agent.save
    #   render json: @agent, status: :ok
    # else
    #   render json: @agent.errors, status: :unprocessable_entity
    # end
  end

  def update
    @agent = ExternalAgent.find(params[:id])
    @agent.update(agent_params)
    if @agent.save
      render json: @agent, status: :ok
    else
      render json: @agent.errors, status: :unprocessable_entity
    end
  end

  private

  def agent_params
    params.permit(:name, :policy_name)
  end
end
