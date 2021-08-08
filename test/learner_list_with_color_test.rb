# frozen_string_literal: true

require "test_helper"
require "tmpdir"
require "fileutils"

# Learner Test
class LearnerTest < Test::Unit::TestCase
  include Learner

  sub_test_case "List with color" do
    def setup
      mk_example_dir
    end

    def teardown
      FileUtils.rm_r(@path)
    end

    test "select file type" do
      assert_match(:ruby.to_s, List.new.select_file_type("hoge.rb"))
      assert_match(:sh.to_s, List.new.select_file_type("hoge.sh"))
      assert_match(:ruby.to_s, List.new.select_file_type("Rakefile"))
      assert_match(:org.to_s, List.new.select_file_type("hoge.org"))
      assert_match(:file.to_s, List.new.select_file_type("hoge.txt"))
    end

    test "lsはexample_dirのfileを表示する" do
      expected = "Files and dirs in \e[0;32;49m#{@path}\e[0m/\n" \
                 "    \e[0;34;49m|--- dir1/\n" \
                 "\e[0m        \e[0;34;49m|--- dir2/\n" \
                 "\e[0m        \e[0;35;49m|--- file3.rb\n" \
                 "\e[0m    \e[0;35;49m|--- file1.rb\n" \
                 "\e[0m    \e[0;36;49m|--- file2.org\n" \
                 "\e[0m"
      assert_equal expected, List.new.ls(@path)
    end

    test "lsはexample_dir/dir1\"/\"のfileを表示する" do
      path = File.join(@path, "dir1/")
      expected = "Files and dirs in \e[0;32;49m#{path[0..-2]}\e[0m/\n" \
                 "    \e[0;34;49m|--- dir2/\n" \
                 "\e[0m    \e[0;35;49m|--- file3.rb\n" \
                 "\e[0m"
      assert_equal expected, List.new.ls(path)
    end

    test "lsはexample_dir/dir1のfileを表示する" do
      path = File.join(@path, "dir1")
      expected = "Files and dirs in \e[0;32;49m#{path}\e[0m/\n" \
                 "    \e[0;34;49m|--- dir2/\n" \
                 "\e[0m    \e[0;35;49m|--- file3.rb\n" \
                 "\e[0m"
      assert_equal expected, List.new.ls(path)
    end
  end
end
