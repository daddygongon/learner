# frozen_string_literal: true

require "thor"
require "command_line/global"
require_relative "learner/version"
require_relative "learner/hello"
require_relative "learner/list"
require_relative "learner/conf"
require_relative "learner/push"
require_relative "learner/pull"

module Learner
  class Error < StandardError; end

  # Your code goes here...
  class CLI < Thor
    desc "hello [NAME]", "say hello to NAME"

    def hello(name = "world")
      puts Hello.new.run(name)
    end

    desc "ls [NAME]", "list NAME"

    def ls(argv = [])
      pwd = Dir.pwd
      origin_dir = Conf.new(pwd).check_dir
      puts List.new(origin_dir).ls(argv)
    rescue RuntimeError => e
      puts e
    end

    desc "conf", "show or setup configuration"

    def conf
      pwd = Dir.pwd
      Conf.new(pwd).run
    end

    desc "push [FILES]", "push FILES.each"

    def push(*files)
      push = Push.new(Conf.new(Dir.pwd).check_dir)
      target_files = Dir.glob(files) || files
      target_files.flatten.each do |file|
        puts push.check_diff(file)
        print "Are you sure to push #{file} [Yn]? ".red
        push.push(file) if $stdin.gets[0] == "Y"
      end
    end

    desc "pull [DIR/FILE]", "pull DIR/FILES.each"

    def pull(*files)
      pull = Pull.new(Conf.new(Dir.pwd).check_dir)
      Dir.glob(files).each do |file|
        next if File.directory?(file)

        puts pull.check_diff(file)
        print "Are you sure to pull #{file} [Yn]? ".red
        pull.pull(file) if $stdin.gets[0] == "Y"
      end
    end
  end
end
