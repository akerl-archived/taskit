##
# Definitions for issue objects
module Taskit
  Label = Struct.new(:name, :color)

  ##
  # An issue object, used to normalize the GitHub API response
  class Issue
    attr_reader :repo, :repo_url, :owner,
                :url, :id, :number, :title, :body, :reporter,
                :labels, :state

    def initialize(raw)
      load_repo_info raw
      load_issue_info raw
      load_state_info raw
    end

    def load_repo_info(raw)
      repo_info = raw[:repository]
      @repo = repo_info[:name]
      @repo_url = repo_info[:html_url]
      @owner = repo_info[:owner][:login]
    end

    def load_issue_info(raw)
      @url, @id, @number, @title, @body = raw.to_h.values_at(
        :html_url, :id, :number, :title, :body
      )
      @reporter = raw[:user][:login]
    end

    def load_state_info(raw)
      @state = raw[:state]
      @labels = raw[:labels].map { |x| Label.new(x[:name], x[:color]) }
    end
  end
end
