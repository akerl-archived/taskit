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
    include Taskit::Filters
    include Taskit::Display

    attr_reader :issues

    def initialize(params = {})
      @options = params
      @client = params[:client]
      @issues = params[:issues]
    end

    def issues
      @issues ||= client.issues(nil, filter: :all).map do |issue|
        Taskit::Issue.new issue
      end
    end

    def to_s
      "<Taskit::Tasks for #{client.login}>"
    end
    alias_method :inspect, :to_s

    private

    def token
      @token ||= Octoauth.new(
        note: 'Taskit',
        api_endpoint: @options[:api_endpoint],
        file: :default,
        autosave: true,
        scopes: ['repo']
      ).token
    end

    def client
      @client ||= Octokit::Client.new(
        access_token: token,
        api_endpoint: @options[:api_endpoint],
        web_endpoint: @options[:api_endpoint],
        auto_paginate: true
      )
    end
  end
end
