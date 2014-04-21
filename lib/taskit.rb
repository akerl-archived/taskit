##
# Taskit parses GitHub issues
module Taskit
  class << self
    ##
    # Insert a helper .new() method for creating a new Tasks object
    def new(*args)
      self::Tasks.new(*args)
    end
  end
end

require 'taskit/tasks'
