require_relative 'coord'
require_relative 'mower'
require 'test/unit'

class MowerTest < Test::Unit::TestCase

    def test_should_return_left_corner_oriented_north_as_default_value
        m = Mower.new
        assert_equal(0, m.coord.X)
        assert_equal(0, m.coord.Y)
        assert_equal(Orientation::NORTH, m.orientation)
    end

    def test_should_raise_if_orientation_is_unknown
        assert_raise(MowerException) { Mower.new(coord: Coord.new, orientation: "A") }
    end
end