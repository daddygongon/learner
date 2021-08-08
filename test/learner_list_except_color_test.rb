# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

# Learner Test
class LearnerTest < Test::Unit::TestCase
  include Learner

  sub_test_case "List except color" do
    def setup
      mk_example_dir
    end

    def teardown
      FileUtils.rm_r(@path)
    end

    test "dir_globはexample_dirのfileのArrayを返す" do
      dir = @path
      assert_equal Dir.glob(File.join(dir, "**/*")), List.new.dir_glob(@path)
    end

    test "List templates" do
      assert_match(/^Files and dirs /, List.new.ls(@path))
    end

    test "get_extend_dir_name" do
      file = "/dir1/dir2/dir1/file3.rb"
      target_dir = "/dir1/dir2"
      assert_equal("/dir1/file3.rb".split("/"),
                   List.new.get_extend_dir_name(file, target_dir))
    end
  end
end
