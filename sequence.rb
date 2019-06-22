module Move
    LEFT    = "L"
    RIGHT   = "R"
    FORWARD = "F"
end

class SequenceException < Exception
end

class Sequence

    attr_accessor :mower, :orders

    def initialize(mower: nil, orders: "")
        validate_orders orders

        @mower    = mower
        @orders   = orders
    end

    def validate_orders(orders)
        raise SequenceException, "orders is a string" unless orders.is_a? String
        orders.each_char do |o|
            unless o == Move::LEFT || o == Move::RIGHT || o == Move::FORWARD
                raise SequenceException, """
                            '#{o}' is not correct \t -- sequence orders is a list of moves like L,R or F.
                             \t\t\t -- #{orders}
                            """
            end
        end
    end
end