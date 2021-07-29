# frozen_string_literal: true

module Learner
  # puts hello
  class List
    def pwd(target_dir='example_dir')
      File.join(File.expand_path("../../..", __FILE__), target_dir)
    end
    def dir_glob(target_dir='example_dir')
      Dir.glob(File.join(pwd(target_dir), '*'))
    end
    def ls(target_dir='example_dir')
      dir_glob(target_dir).each {|file| puts file}
    end
  end
end
