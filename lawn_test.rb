require_relative 'coord'
require_relative 'mower'
require_relative 'lawn'
require_relative 'sequence'
require 'test/unit'

class LawnTest < Test::Unit::TestCase

    def test_should_add_a_mower_with_coordinates_inside_the_lawn

        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower   = Mower.new coord: Coord.new(x:3, y: 4), orientation: Orientation::SOUTH

        # when
        lawn << Sequence.new(mower: mower)

        # then
        lawn.each do |mower|
            assert_equal(3, mower.coord.X)
            assert_equal(4, mower.coord.Y)
            assert_equal(Orientation::SOUTH, mower.orientation)
        end
    end

    def test_should_raise_a_mower_with_coordinates_outside_the_lawn

        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower   = Mower.new coord: Coord.new(x:30, y: 4), orientation: Orientation::SOUTH

        # when / then
        assert_raise( CoordinateException ) { lawn << Sequence.new(mower: mower) }

    end

    def test_should_add_only_sequence_family

        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square

        # when / then
        assert_raise( LawnException ) { lawn << "a string" }
    end

    def test_should_move_mower_two_step_forward
    
        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower   = Mower.new

        # when
        lawn << Sequence.new(mower: mower, orders: "FF")

        # then
        lawn.each do |m|
            assert_equal(0, m.coord.X)
            assert_equal(2, m.coord.Y)
        end
    end

    def test_should_move_mower_orientation_to_EST
    
        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower   = Mower.new

        # when
        lawn << Sequence.new(mower: mower, orders: "R")

        # then
        lawn.each do |m|
            assert_equal(0, m.coord.X)
            assert_equal(0, m.coord.Y)
            assert_equal(Orientation::EST, m.orientation)
        end
    end

    def test_should_do_nothing_if_mower_goes_away_during_his_trip
        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower   = Mower.new

        # when
        lawn << Sequence.new(mower: mower, orders: "LFFLFFRFRFFRFF")

        # then
        lawn.each do |m|
            assert_equal(2, m.coord.X)
            assert_equal(2, m.coord.Y)
            assert_equal(Orientation::EST, m.orientation)
        end
    end

    def test_should_go_on_top_right_corner
        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower   = Mower.new

        # when
        lawn << Sequence.new(mower: mower, orders: "RFFFLFFFRFFFFLFFFFFL")

        # then
        lawn.each do |m|
            assert_equal(5, m.coord.X)
            assert_equal(5, m.coord.Y)
            assert_equal(Orientation::WEST, m.orientation)
        end
    end

    def test_do_nothing_if_a_mower_is_front_of_another
        # given
        square  = Coord.new(x: 5, y: 5)
        lawn    = Lawn.new square
        mower1  = Mower.new
        mower2  = Mower.new

        # when
        lawn << Sequence.new(mower: mower1, orders: "FF")
        lawn << Sequence.new(mower: mower2, orders: "FF")

        # then
        mowers = []
        lawn.each { |m| mowers << m }
        
        assert_equal(0, mowers[0].coord.X)
        assert_equal(2, mowers[0].coord.Y)
        assert_equal(Orientation::NORTH, mowers[0].orientation)

        assert_equal(0, mowers[1].coord.X)
        assert_equal(1, mowers[1].coord.Y)
        assert_equal(Orientation::NORTH, mowers[1].orientation)
    end

end