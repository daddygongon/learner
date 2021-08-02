# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

# Learner Test
class LearnerTest < Test::Unit::TestCase
  include Learner

  sub_test_case "List with dummy dir" do
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

    test "lsはexample_dirのfileを表示する" do
      assert do
        List.new.ls(@path)
      end
    end
  end
end
