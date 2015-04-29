require 'yaml'
require 'twitter'

module TwitterUtility
  class Account
    class << self
      def configure
        @@configure ||= YAML.load_file(File.expand_path(File.join(__FILE__, '..', '..', '..', 'config', 'account.yml')))
      end
    end

    def initialize(name)
      @configure = self.class.configure[name]
    end

    def api_client
      @api_client ||= ::Twitter::REST::Client.new do |config|
        config.consumer_key        = @configure['consumer_key']
        config.consumer_secret     = @configure['consumer_secret']
        config.access_token        = @configure['access_token']
        config.access_token_secret = @configure['access_token_secret']
      end
    end
  end
end
