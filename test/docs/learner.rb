# frozen_string_literal: true

require "thor"
require_relative "learner/version"
require_relative "learner/hello"
require_relative "learner/list"

module Learner
  class Error < StandardError; end

  # Your code goes here...
  class CLI < Thor
    desc "hello [NAME]", "say hello to NAME"
    def hello(name = "world")
      puts Hello.new.run(name)
    end
  end
end
