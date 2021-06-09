# frozen_string_literal: true

# Authenticate clients to webhooks service
class TokenService
  # App connecting to the service
  def initialize(server_name:)
    @server_name = server_name
  end

  def valid_token?(token:)
    token == authentication_token
  end

  def authentication_token
    Rails.cache.delete "current_secret:#{@server_name}" if authentication_token_expired?
    cached_authentication_token[:secret]
  end

  def cached_authentication_token
    Rails.cache.fetch("current_secret:#{@server_name}") do
      fetch_key_from_vault
    end
  end

  # This will return structure like {secret: "secret", expires: 12345678 }
  def fetch_key_from_vault
    reauthenticate_vault unless @vault
    begin
      result = read_from_vault
    rescue Vault::HTTPError => e
      Rails.logger.error(e)
      if e.code == 403
        Rails.logger.info 'Received 403 from Vault.  Reauthenticating.'
        reauthenticate_vault
        result = read_from_vault
      else
        Rails.logger.info "Received #{e.code} from vault.  #{e.message}"
        raise e
      end
    end
    Rails.logger.error("result data: #{result.data}")
    result.data
  end

  def read_from_vault
    vault_secret_path = "orchestrator/servers/#{@server_name}"
    # byebug
    @vault.kv('kv').read(vault_secret_path)
  end

  def reauthenticate_vault
    Rails.logger.info 'reauthenticate_vault'
    @vault = Vault::Client.new(address: ENV['VAULT_ADDR'])
    @vault
  end

  def authentication_token_expired?
    Time.now.to_i > cached_authentication_token[:expires].to_i
  end
end
