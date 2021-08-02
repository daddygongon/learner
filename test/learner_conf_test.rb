# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

# Learner Test
class LearnerTest < Test::Unit::TestCase
  include Learner

  def mk_example_dir(dirs = ["dir1", "dir1/dir2"],
                     files = ["file1.rb", "file2.org", "dir1/file3.rb"])
    @tmp = Dir.tmpdir
    @path = "#{@tmp}/learner_example_dir"
    Dir.mkdir(@path)
    dirs.each { |dir| Dir.mkdir(File.join(@path, dir)) }
    files.each do |file|
      File.open(File.join(@path, file), "w") { |f| f.print("this is #{file}.") }
    end
  end

  sub_test_case "Conf with .learner.conf" do
    test "check_confは.learner.confが存在するかを確認する" do
      mk_example_dir(["dir1"], [".learner.conf"])
      assert_true Conf.new(@path).check_conf
    ensure
      FileUtils.rm_r(@path)
    end
  end

  sub_test_case "Conf without .learner.conf" do
    def setup
      mk_example_dir(["dir1"], [])
    end

    def teardown
      FileUtils.rm_r(@path)
    end

    test "check_confは.learner.confが存在するかを確認する" do
      assert_false Conf.new(@path).check_conf
    end
    test "dump_confは.learner.confにorigin_dirのdefaultを保存する" do
      Conf.new(@path).dump_conf
      assert_equal("{\"origin_dir\":\"TODO: change dir to origin\"}",
                   File.read(File.join(@path, ".learner.conf")))
    end
    test "load_confはorigin_dirを読み出す" do
      learner_conf = Conf.new(@path)
      learner_conf.dump_conf
      conf = learner_conf.load_conf
      assert_equal("TODO: change dir to origin", conf["origin_dir"])
    end
  end

  sub_test_case "Conf::check_dir" do
    def setup
      mk_example_dir(["dir1"], [])
      @learner_conf = Conf.new(@path)
    end

    def teardown
      FileUtils.rm_r(@path)
    end

    test "origin_dirを返す" do
      @learner_conf.dump_conf(Dir.pwd)
      dir = @learner_conf.check_dir
      assert_equal(Dir.pwd, dir)
    end

    test "defaultで書かれた\"TODO\"が直ってないとerrorを返す" do
      @learner_conf.dump_conf
      assert_raise(RuntimeError) { @learner_conf.check_dir }
    end
    test ".learner.confがないとerrorを返す" do
      assert_raise(RuntimeError) { @learner_conf.check_dir }
    end

    test "original dirがないとerrorを返す" do
      @learner_conf = Conf.new(@path)
      @learner_conf.dump_conf
      assert_raise(RuntimeError) { @learner_conf.check_dir }
    end
  end
end
