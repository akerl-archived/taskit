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
    attr_reader :issues

    def initialize(params = {})
      @client = _client(params)
      @issues = Taskit::Issues.new @client.issues(nil, filter: :all)
    end

    def to_s
      "<Taskit::Tasks for #{@client.login}>"
    end
    alias_method :inspect, :to_s

    private

    def _token(params = {})
      auth = Octoauth.new(
        note: 'Taskit',
        api_endpoint: params[:api_endpoint],
        file: :default,
        scopes: ['repo']
      )
      auth.save
      auth.token
    end

    def _client(params = {})
      Octokit::Client.new(
        access_token: _token(params),
        api_endpoint: params[:api_endpoint],
        web_endpoint: params[:api_endpoint],
        auto_paginate: true
      )
    end
  end
end

require 'taskit/tasks/issue.rb'
