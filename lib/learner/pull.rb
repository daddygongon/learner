# frozen_string_literal: true

require "colorize"
require "fileutils"
require_relative "list"

module Learner
  # Pull file from target_dir to pwd
  class Pull < Push
    def check_diff(file)
      @cp_source = File.join(@root_dir, file)
      puts "Checking #{file} and #{@cp_source}...".green
      if File.exist?(file)
        show_diff(@cp_source, file)
      else
        "#{file} does not exist in pwd"
      end
    end

    def dir_glob(file)
      Dir.glob(File.join(@root_dir, file))
    end

    def pull(file)
      @cp_source = File.join(@root_dir, file)
      @cp_target = File.join(Dir.pwd, file)
      FileUtils.mkdir_p(File.expand_path("..", @cp_target))
      FileUtils.cp(@cp_source, @cp_target, verbose: true)
    end
  end
end
