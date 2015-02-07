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

    def initialize(data)
      load_repo_info data
      load_issue_info data
      load_state_info data
    end

    def load_repo_info(data)
      repo_info = data[:repository]
      @repo = repo_info[:name]
      @repo_url = repo_info[:html_url]
      @owner = repo_info[:owner][:login]
    end

    def load_issue_info(data)
      @url, @id, @number, @title, @body = data.to_h.values_at(
        :html_url, :id, :number, :title, :body
      )
      @reporter = data[:user][:login]
    end

    def load_state_info(data)
      @state = data[:state]
      @labels = data[:labels].map { |x| Label.new(x[:name], x[:color]) }
    end
  end
end
