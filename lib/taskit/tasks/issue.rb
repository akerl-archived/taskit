##
# Definitions for issue objects
module Taskit
  ISSUE_LABEL = Struct.new(:name, :color)

  ##
  # An issue object, used to normalize the GitHub API response
  class Issue
    attr_reader :repo, :repo_url, :owner,
                :url, :id, :number, :title, :body, :reporter,
                :labels, :state

    def initialize(raw)
      @raw = raw
      load_repo_info
      load_issue_info
      load_state_info
    end

    def load_repo_info
      repo_info = @raw[:repository]
      @repo = repo_info[:name]
      @repo_url = repo_info[:html_url]
      @owner = repo_info[:owner][:login]
    end

    def load_issue_info
      @url, @id, @number, @title, @body = @raw.values_at(
        :html_url, :id, :number, :title, :body
      )
      @reporter = @raw[:user][:login]
    end

    def load_state_info
      @state = @raw[:state]
      @labels = @raw[:labels].map { |x| ISSUE_LABEL.new(x[:name], x[:color]) }
    end
  end
end
