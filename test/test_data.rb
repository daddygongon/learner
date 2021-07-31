require "test-unit"

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
