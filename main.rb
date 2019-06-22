require_relative 'coord'
require_relative 'mower'
require_relative 'lawn'
require_relative 'sequence'

abort "usage: main.rb /path/to/file" unless ARGV.length == 1
file        = ARGV[0]

lawn        = nil
mower       = nil
begin
    File.open(file).each_with_index do |line, index|
        
        # the first line is the lawn measurement
        # <?>.to_i returns 0 if number is not a number
        if(index == 0)
            x,y     = line.split(" ").map(&:to_i)
            
            raise Exception,
            """
                the first line is incorrect. Syntax is X<space>Y
                current line: #{line}
            """ unless x > 0 && y > 0

            # we are creating a lawn
            lawn    = Lawn.new(Coord.new(
                                x: x.to_i, 
                                y: y.to_i
                            )
                    )

        elsif(index.odd?)
            x,y,z   = line.split(" ")

            # we are creating a new mower
            mower   = Mower.new(
                        coord: Coord.new(
                                x: x.to_i, 
                                y: y.to_i
                            ),
                        orientation: z
                    )

        else

            # we are applying a sequence of movements on the lawn (for a given mower)
            # it raise an exception if the mower is parked outside the lawn
            # or on an existing mower
            lawn << Sequence.new(
                        mower: mower, 
                        orders: line.strip!||line # it's because of line contains CLRF except for the last line
                    )
        end

    end
rescue Exception => e
    abort e.message
end

# report
lawn.each { |mower| puts mower }