# -*- coding: utf-8 -*-
# frozen_string_literal: true

require "test_helper"

class LearnerTest < Test::Unit::TestCase
  include Learner
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
      assert_equal(File.join(File.expand_path("../..",__FILE__),'example_dir'),
                   List.new.pwd('example_dir') )
    end
    test "dir_globはexample_dirのfileのArrayを返す" do
      dir = File.join(File.expand_path("../..",__FILE__),'example_dir','*')
      assert_equal  Dir.glob(dir) ,List.new.dir_glob('example_dir')
    end
    test "lsはexample_dirのfileを表示する" do
      assert do
        List.new.ls('example_dir')
      end
    end
  end

  sub_test_case "Confはpwdにある.learner.confというファイルからorigin_dirを読み込む" do
    test "pwdが正しく返る" do
      assert_equal(
                   File.expand_path("../..",__FILE__),
                   Conf.new.pwd
                   )
    end
    test "check_confは.learner.confが存在するかを確認する" do
      assert_false Conf.new.check_conf
    end
  end
end
