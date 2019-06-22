require_relative 'mower'
require_relative 'sequence'
require_relative 'coord'
require 'test/unit'

class SequenceTest < Test::Unit::TestCase

    def test_should_accept_empty_sequence()
        # given
        s = Sequence.new

        assert_nil(s.mower)
        assert_equal("", s.orders)
    end

    def test_should_raise_if_order_is_not_a_string()
        # given / when / then
        assert_raise(SequenceException) { Sequence.new orders: 1 }
    end

    def test_should_raise_if_orders_are_unknown()
        # given / when / then
        assert_raise(SequenceException) { Sequence.new orders: " " }
        assert_raise(SequenceException) { Sequence.new orders: "A" }
        assert_raise(SequenceException) { Sequence.new orders: "@" }
        assert_raise(SequenceException) { Sequence.new orders: "-" }
        assert_raise(SequenceException) { Sequence.new orders: "%" }
        assert_raise(SequenceException) { Sequence.new orders: "4" }
        assert_raise(SequenceException) { Sequence.new orders: "f" }
        assert_raise(SequenceException) { Sequence.new orders: "FFR R" }
    end

    def test_should_validate_properly_if_orders_are_known_without_space()
        # given / when / then
        s = Sequence.new orders: "FFRR"
        assert_equal("FFRR", s.orders)
    end

end