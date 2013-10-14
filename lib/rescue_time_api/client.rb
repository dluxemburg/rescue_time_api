require 'date'
require 'faraday'
require 'faraday_middleware'

module RescueTimeApi
  class Client

    attr_accessor :key, :host, :base_path

    def initialize(options)
      @key = options.fetch(:key)
      @host = options.fetch(:host,"www.rescuetime.com")
      @base_path = options.fetch(:base_path,"/anapi/data")
    end

    def connection
      @connection ||= get_connection
    end

    def get_connection
      Faraday.new(:url => "https://#{host}") do |conn|
        conn.request    :json
        conn.response   :json, :content_type => /\bjson$/
        conn.adapter    Faraday.default_adapter
      end
    end

    def request(params)
      params = format_params(params)
      Response.new(run_request(params))
    end

    def run_request(params)
      connection.get(base_path,params.merge(default_params))
    end

    def current_user_name
      request({perspective: 'member'}).rows.first['person']
    end

    def default_params
      {key: key, format: 'json'}
    end

    def format_params(params)
      time_keys.each do |key|
        if params[key] && params[key].respond_to?(:to_date)
          params[key] = params[key].to_date.to_s
        end
      end
      params
    end

    def time_keys
      keys = ['re','restrict_end','rb','restrict_begin']
      return keys + keys.map(&:to_sym)
    end

  end
end
