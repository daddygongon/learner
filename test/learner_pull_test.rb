# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

# Learner Test
class LearnerTest < Test::Unit::TestCase
  include Learner
  sub_test_case "Pull" do
    test "test/test_sample.txtをcp" do
      mk_example_dir(["test"], [])
      FileUtils.cp("test/test_sample.txt", File.join(@path, "test"))
      file = File.join(@path, "test/test_sample.txt")
      assert_true File.exist?(file)
    ensure
      FileUtils.rm_r(@path)
    end

    test "Pull.dir_globはファイルを表示" do
      mk_example_dir(["test"], [])
      target_file1 = "test/test_sample_1.txt"
      target_file2 = "test/test_sample_2.txt"
      FileUtils.cp(target_file1, File.join(@path, target_file1))
      FileUtils.cp(target_file2, File.join(@path, target_file2))
      Pull.new(@path).dir_glob("test")
    ensure
      FileUtils.rm_r(@path)
    end

    test "Pull.remove_root_dir_pathはfile, root_dirをよしなに変形(not yet)" do
    end

    test "Pull.pullはp_dirがないと作る(not yet)" do
    end

    test "Pull.pullはsourceをtargetにcopy(not yet)" do
    end
  end
end
