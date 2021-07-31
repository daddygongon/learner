# frozen_string_literal: true

require "thor"
require_relative "learner/version"
require_relative "learner/hello"
require_relative "learner/list"
require_relative "learner/conf"

module Learner
  class Error < StandardError; end

  # Your code goes here...
  class CLI < Thor
    desc "hello [NAME]", "say hello to NAME"

    def hello(name = "world")
      puts Hello.new.run(name)
    end

    desc "ls [NAME]", "list NAME"

    def ls(name = "example_dir")
      List.new.ls(name)
    end

    desc "conf", "show or setup configuration"

    def conf
      pwd = Dir.pwd
      Conf.new(pwd).run
    end
  end
end
