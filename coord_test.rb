require_relative 'coord'
require 'test/unit'

class CoordTest < Test::Unit::TestCase
    
    def test_should_not_be_negative
        assert_raise( CoordinateException ) { Coord.new x: -1 }
        assert_raise( CoordinateException ) { Coord.new y: -1 }
    end

    def test_should_return_0_as_default_value
        c = Coord.new
        assert_equal(0, c.X)
        assert_equal(0, c.Y)
    end
end