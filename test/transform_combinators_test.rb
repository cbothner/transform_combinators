require "test_helper"

class TransformCombinatorsTest < Minitest::Test
  include TransformCombinators

  def test_that_it_has_a_version_number
    refute_nil ::TransformCombinators::VERSION
  end

  def test_same
    assert_equal 12, same.(12)
  end

  def test_hash_of
    user = { name: "Martin", age: 23 }
    assert_equal({ name: "Martin" }, hash_of.({ name: same }).(user))
  end

  def test_scalar_return_value_if_scalar
    assert_equal(12, scalar.(12))
  end

  def test_scalar_returns_nil_if_hash
    assert_nil scalar.({})
  end

  def test_scalar_returns_nil_if_array
    assert_nil scalar.([])
  end

  def test_default_returns_default_value_on_nil
    assert_equal 12, default.(12).(nil)
  end

  def test_default_returns_the_input_value_when_not_nil
    assert_equal 10, default.(12).(10)
  end

  def test_float_convertion
    assert_equal 123.3, float.("123.3")
  end

  def test_float_convertion_should_raise_an_error_if_not_float
    assert_raises TypeError do
      float.(nil)
    end
  end

  def test_null_string_with_non_empty_string
    assert_equal "a", null_string.("a")
  end

  def test_null_string_with_empty_string
    assert_nil null_string.("")
  end

  def test_null_string_with_empty_string
    assert_nil null_string.("  ")
  end

  def test_null_string_with_nil_string
    assert_nil null_string.(nil)
  end
end
