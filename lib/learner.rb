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
      target_dir = Conf.new(Dir.pwd).check_dir
      push = Push.new(target_dir)
      files.each do |file|
        puts push.check_diff(file)
        print "Are you sure to push #{file} [Yn]? ".red
        ans = $stdin.gets
        push.push(file) if ans[0] == "Y"
      end
    end

    desc "pull [DIR/FILE]", "pull DIR/FILES.each"

    def pull(*files)
      target_dir = Conf.new(Dir.pwd).check_dir
      pull = Pull.new(target_dir)
      pull.dir_glob(files).each do |file|
        next if File.directory?(file)

        puts pull.check_diff(file)
        print "Are you sure to pull #{file} [Yn]? ".red
        ans = $stdin.gets
        pull.pull(file) if ans[0] == "Y"
      end
    end
  end
end
