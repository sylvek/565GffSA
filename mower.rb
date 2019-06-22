module Orientation
    NORTH   = "N"
    SOUTH   = "S"
    EST     = "E"
    WEST    = "W"
end

class MowerException < Exception
end

class Mower
    attr_accessor :coord, :orientation

    def initialize(coord: Coord.new, orientation: Orientation::NORTH)
        @coord          = coord
        @orientation    = orientation

        raise MowerException,
            """
                '#{orientation}' is not correct.
                known values: N,E,W,S
            """ unless 
                orientation == Orientation::NORTH ||
                orientation == Orientation::SOUTH ||
                orientation == Orientation::EST   ||
                orientation == Orientation::WEST
    end

    def to_s
        "#{@coord.X} #{@coord.Y} #{@orientation}"
    end
end