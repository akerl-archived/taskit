module Taskit
  ##
  # Define filters for selecting issues
  class Filters
    def by_repo(repo)
      Taskit::Tasks.new(
        _issues: @issues.select { |issue| issue.repo == repo }
      )
    end
  end
end
