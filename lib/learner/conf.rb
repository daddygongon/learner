# frozen_string_literal: true

require "json"

module Learner
  # configuration class
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

    def check_dir
      raise "No file #{@file_path}" unless File.exist?(@file_path)

      @conf = JSON.parse(File.read(@file_path))
      @origin_dir = @conf["origin_dir"]

      raise "Edit origin_dir in #{@file_path}." if @origin_dir.include?("TODO")

      raise "No valid path in #{@file_path}." unless File.exist?(@origin_dir)

      @origin_dir
    end

    def load_conf
      puts "learner configuration read from #{@file_path}."
      puts "If necessary, edit #{@file_path} in JSON format."
      cont = File.read(@file_path)
      @conf = JSON.parse(cont)
      pp @conf
    end

    def dump_conf(target_dir = "TODO: change dir to origin")
      @conf = { "origin_dir" => target_dir }
      File.open(@file_path, "w") do |f|
        JSON.dump(@conf, f)
      end
      puts "edit \"TODO: change dir to origin\" in ./.learner.conf"
    end
  end
end
