require 'octoauth'
require 'octokit'
require 'faraday-http-cache'

##
# Define Tasks and related objects for Taskit
module Taskit
  ##
  # Cache layer for GitHub API
  API_CACHE = Faraday::RackBuilder.new do |builder|
    builder.use Faraday::HttpCache
    builder.use Octokit::Response::RaiseError
    builder.adapter Faraday.default_adapter
  end

  ##
  # Tasks object holds and returns information on open issues
  class Tasks
    def initialize(params = {})
      @client = client(params)
    end

    def client(params = {})
      token = Octoauth.new note: 'Taskit', api_endpoint: params[:api_endpoint]
      Octokit::Client.new(
        access_token: token,
        api_endpoint: params[:api_endpoint],
        web_endpoint: params[:api_endpoint]
      )
    end
  end
end
