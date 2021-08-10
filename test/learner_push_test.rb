# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

# Learner Test
class LearnerTest < Test::Unit::TestCase
  include Learner

  sub_test_case "Push" do
    test "test/test_sample.txtをcp" do
      mk_example_dir(["test"], [])
      FileUtils.cp("test/test_sample.txt", File.join(@path, "test"))
      file = File.join(@path, "test/test_sample.txt")
      assert_true File.exist?(file)
    ensure
      FileUtils.rm_r(@path)
    end

    test "Push.check_diffは違うファイルを表示" do
      mk_example_dir(["test"], [])
      target_file1 = "test/test_sample_1.txt"
      target_file2 = "test/test_sample_2.txt"
      FileUtils.cp(target_file2, File.join(@path, "test/test_sample_1.txt"))
      text = "1c1\n" \
             "\e[0;39;107mthere:< test sample 2.\e[0m\n" \
             "---\n" \
             "\e[0;39;106mhere:> test sample 1.\e[0m"
      assert_equal(text,
                   Push.new(@path).check_diff(target_file1))
    ensure
      FileUtils.rm_r(@path)
    end
    test "Push.check_diffは同じファイルを表示" do
      mk_example_dir(["test"], [])
      target_file1 = "test/test_sample_1.txt"
      target_file2 = "test/test_sample_1.txt"
      target = File.join(@path, "test/test_sample_1.txt")
      FileUtils.cp(target_file2, target)
      assert_equal("No diff between #{target_file1} and #{target}",
                   Push.new(@path).check_diff(target_file1))
    ensure
      FileUtils.rm_r(@path)
    end
  end
end
