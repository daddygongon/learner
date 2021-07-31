# -*- coding: undecided -*-
require "test-unit"
# [[https://www.clear-code.com/blog/2013/1/23.html][データ駆動テストの紹介]]

class TestData < Test::Unit::TestCase
  data do
    data_set = {}
    data_set["empty string"] = [true, ""]
    data_set["plain string"] = [false, "hello"]
    data_set
  end
  def test_empty?(data)
    expected, target = data
    assert_equal(expected, target.empty?)
  end
end
