# frozen_string_literal: true

require "colorize"

module Learner
  # puts hello
  class List
    def initialize(root_dir = "")
      @root_dir = root_dir
    end

    def pwd(target_dir = "example_dir")
      if target_dir == "example_dir"
        File.join(File.expand_path("../../", __dir__), target_dir)
      else
        target_dir
      end
    end

    def dir_glob(target_dir = "example_dir")
      Dir.glob(File.join(target_dir, "**/*"))
    end

    def ls(target_dir = "example_dir")
      target_dir = File.join(@root_dir, target_dir)
      raise "#{target_dir} does not exist.".red unless File.exist?(target_dir)

      text = "Files and dirs in #{target_dir.green}/\n"

      dir_glob(target_dir).sort.each do |file|
        file_type = F_TYPE[select_file_type(file)]
        res = file.split("/") - target_dir.split("/")
        text << mk_list(res, file_type)
      end
      text
    end

    F_TYPE = { dir: { term: "/", color: :blue },
               ruby: { term: "", color: :magenta },
               sh: { term: "", color: :green },
               org: { term: "", color: :cyan },
               file: { term: "", color: :black } }.freeze

    def select_file_type(file)
      if FileTest.directory?(file)
        :dir
      elsif File.basename(file) == "Rakefile"
        :ruby
      else
        case File.extname(file)
        when ".rb" then :ruby
        when ".sh" then :sh
        when ".org" then :org
        else :file
        end
      end
    end

    def mk_list(res, file_type, level = 3)
      return "" unless res.size < level

      text = "    " * (res.size - 1)
      text << "|---#{res[-1]}#{file_type[:term]}\n".colorize(file_type[:color])
    end
  end
end
