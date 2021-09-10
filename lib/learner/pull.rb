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

    def remove_root_dir_path(file, root_dir)
      f_sep = File::SEPARATOR
      root_path = root_dir.split(f_sep)
      file_path = file.split(f_sep)
      root_path.each do |name|
        file_path.shift if file_path[0] == name
      end
      file_path.join(f_sep)
    end

    def dir_glob(files)
      target_files = Dir.glob(File.join(@root_dir, files))
      target_files.collect do |file|
        next if File.directory?(file)

        remove_root_dir_path(file, @root_dir)
      end
    end

    def pull(file)
      @cp_source = File.join(@root_dir, file)
      @cp_target = File.join(Dir.pwd, file)
      p_dir = File.expand_path("..", @cp_target)
      FileUtils.mkdir_p(p_dir, verbose: true) unless File.exist?(p_dir)
      FileUtils.cp(@cp_source, @cp_target, verbose: true)
    end
  end
end
