require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    board = GameBoard.new 10, 10
    lines = read_file_lines(path)
    shipcount = 0
    if lines != nil
        read_file_lines(path) { |line|
            if line =~ /^.(\d+).(\d+)., (Right|Left|Up|Down), (\d+){1,5}$/
                row = $1.to_i
                column = $2.to_i
                size = $4.to_i
                line = line.split
                line[1] = line[1].delete(",")
                orientation = line[1]
                position1 = Position.new(row,column)
                ship1 = Ship.new(position1, orientation,size)
                if board.add_ship(ship1) == true
                    shipcount = shipcount + 1
                end
            end
        }
        if shipcount == 5
            return board
        else
            return nil
        end
    end
    return nil
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    [Position.new(1, 1)]
    if read_file_lines(path) == nil
        return nil
    end
    final = []
    read_file_lines(path){ |line|
        if line =~ /^.(\d+).(\d+).$/
            line = line.split
            row = line[0].to_i
            column = line[1].to_i
            position1 = Position.new(row,column)
            final.push(position1)
        end

    }
    return final
end


# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end
