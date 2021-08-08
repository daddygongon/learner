# -*- coding: utf-8 -*-
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

    test "Push.pushはtest/test_sample.txtをpush" do
      mk_example_dir(["test"], [])
      target_file = "test/test_sample.txt"
      FileUtils.cp(target_file, File.join(@path, "test"))
      file = File.join(@path, target_file)
      Push.push(target_file)
    ensure
      FileUtils.rm_r(@path)
    end
  end
end
