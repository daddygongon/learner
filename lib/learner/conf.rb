# frozen_string_literal: true
require "json"

module Learner
  # puts hello
  class Conf
    def initialize(path)
      @path = path
      @file_path = File.join(@path, ".learner.conf")
    end

    def run
      if check_conf
        load_conf
      else
        dump_conf
      end
    end

    def check_conf
      File.exist?(@file_path)
    end

    require "pp"

    def load_conf
      puts "learner configuration read from ./.learner.conf."
      puts "If necessary, edit ./.learner.conf in JSON format."
      cont = File.read(@file_path)
      @conf = JSON.load(cont)
      pp @conf
    end

    def dump_conf
      @conf = { "origin_dir" => "TODO: change dir to origin" }
      File.open(@file_path, "w") do |f|
        JSON.dump(@conf, f)
      end
      puts "edit \"TODO: change dir to origin\" in learner.conf"
    end
  end
end
