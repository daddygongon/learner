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

    def multi_files(files, push_or_pull)
      target_files = Dir.glob(files) || files
      target_files.flatten.each do |file|
        puts push_or_pull.check_diff(file)
        print "Are you sure to push #{file} [Yn]? ".red
        ans = $stdin.gets
        push_or_pull.run(file) if ans[0] == "Y"
      end
    end

    desc "push [FILES]", "push FILES.each"

    def push(*files)
      push = Push.new(Conf.new(Dir.pwd).check_dir)
      multi_files(files, push)
    end

    desc "pull [DIR/FILE]", "pull DIR/FILES.each"

    def pull(*files)
      pull = Pull.new(Conf.new(Dir.pwd).check_dir)
      multi_files(files, pull)
    end
  end
end
