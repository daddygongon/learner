# frozen_string_literal: true

module Learner
  # puts hello
  class List
    def pwd(target_dir = "example_dir")
      if target_dir == "example_dir"
        File.join(File.expand_path("../../..", __FILE__), target_dir)
      else
        target_dir
      end
    end

    def dir_glob(target_dir = "example_dir")
      files = File.join(pwd(target_dir), "**/*")
      Dir.glob(files)
    end

    def ls(target_dir = "example_dir")
      dir_glob(target_dir).each do |file|
        puts (file.split("/") - target_dir.split("/")).join("/")
      end
    end
  end
end
