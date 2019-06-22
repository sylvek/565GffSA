class LawnException < Exception
end
class Lawn

    include Enumerable

    def initialize(coord)
        @coord = coord
        @mowers = []
    end

    def <<(sequence)
        raise LawnException, "only sequence could be added" unless sequence.is_a? Sequence

        mower = sequence.mower
        raise CoordinateException, 
              """
              #{mower}: coordinates are outside
              """ if is_outside?(mower.coord)
        raise CoordinateException,
              """
              #{mower}: coordinates are not free
              """ if !is_free?(mower.coord)

        @mowers << apply(sequence)
    end

    def is_outside? c
        # are we in the lawn?
        c.X < 0 || c.Y < 0 || 
        c.X > @coord.X || c.Y > @coord.Y
    end

    def is_free? c
        # is there another mower with this coordinates?
        @mowers.select { |m| c.X == m.coord.X && c.Y == m.coord.Y }.empty?
    end

    def each(&block)
        @mowers.each(&block)
    end

    def apply(sequence)
        sequence.orders.each_char do |order|

            current_coord = Coord.new(
                                x:sequence.mower.coord.X, 
                                y:sequence.mower.coord.Y
                            )

            case order
            when Move::FORWARD
                current_coord.Y += 1 if sequence.mower.orientation == Orientation::NORTH
                current_coord.Y -= 1 if sequence.mower.orientation == Orientation::SOUTH
                current_coord.X += 1 if sequence.mower.orientation == Orientation::EST
                current_coord.X -= 1 if sequence.mower.orientation == Orientation::WEST
            when Move::RIGHT
                case sequence.mower.orientation
                when Orientation::NORTH
                    sequence.mower.orientation = Orientation::EST
                when Orientation::SOUTH
                    sequence.mower.orientation = Orientation::WEST
                when Orientation::EST
                    sequence.mower.orientation = Orientation::SOUTH
                when Orientation::WEST
                    sequence.mower.orientation = Orientation::NORTH
                end
            when Move::LEFT
                case sequence.mower.orientation
                when Orientation::NORTH
                    sequence.mower.orientation = Orientation::WEST
                when Orientation::SOUTH
                    sequence.mower.orientation = Orientation::EST
                when Orientation::EST
                    sequence.mower.orientation = Orientation::NORTH
                when Orientation::WEST
                    sequence.mower.orientation = Orientation::SOUTH
                end
            end

            if  (!is_outside?(current_coord) && is_free?(current_coord))
                sequence.mower.coord = current_coord
            end

        end

        sequence.mower
    end

end