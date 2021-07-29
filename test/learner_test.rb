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
    test "pwdはtest/docsへのpathを返す" do
      assert_equal(File.join(File.expand_path("..",__FILE__),'docs'),
                   List.new.pwd('test/docs') )
    end
    test "dir_globはtest/docsのfileを返す" do
      dir = File.join(File.expand_path("..",__FILE__),'docs','*')
      assert_equal  Dir.glob(dir) ,List.new.dir_glob('test/docs')
    end
    test "lsはtest/docsのfileを表示する" do
      assert do
        List.new.ls('test/docs')
      end
    end
  end
end
