# -*- coding: utf-8 -*-
# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

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

  test "VERSION" do
    assert do
      ::Learner.const_defined?(:VERSION)
    end
  end

  test "Helloは\"Hello HOGEHOGE.\"を返す" do
    assert_equal("Hello Rudy.", Hello.new.run("Rudy"))
    assert_not_equal("Hello Rud.", Hello.new.run("Rudy"))
    assert_equal("Hello world.", Hello.new.run)
  end

  sub_test_case "List" do
    test "pwdはexample_dirへのpathを返す" do
      assert_equal(File.join(File.expand_path("../..", __FILE__), "example_dir"),
                   List.new.pwd("example_dir"))
    end
    test "dir_globはexample_dirのfileのArrayを返す" do
      dir = File.join(File.expand_path("../..", __FILE__), "example_dir", "*")
      assert_equal Dir.glob(dir), List.new.dir_glob("example_dir")
    end
    test "lsはexample_dirのfileを表示する" do
      assert do
        List.new.ls("example_dir")
      end
    end
  end

  sub_test_case "List with dummy dir" do
    def setup
      mk_example_dir
    end

    def teardown
      FileUtils.rm_r(@path)
    end

    test "dir_globはexample_dirのfileのArrayを返す" do
      dir = @path
      assert_equal Dir.glob(File.join(dir, "**/*")),
        List.new.dir_glob(@path)
    end

    test "lsはexample_dirのfileを表示する" do
      assert do
        List.new.ls(@path)
      end
    end
  end

  sub_test_case "Conf with .learner.conf" do
    def setup
      mk_example_dir(["dir1"], [".learner.conf"])
    end

    def teardown
      FileUtils.rm_r(@path)
    end

    test "check_confは.learner.confが存在するかを確認する" do
      assert_true Conf.new(@path).check_conf
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
      conf = learner_conf.load_conf()
      assert_equal("TODO: change dir to origin", conf["origin_dir"])
    end
  end
end
