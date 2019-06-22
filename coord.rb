class CoordinateException < Exception
end
class Coord
    attr_accessor :X, :Y

    def initialize(x: 0, y: 0)

        raise CoordinateException, "coordinates must be positive" if x < 0 || y < 0

        @X = x
        @Y = y
    end
end