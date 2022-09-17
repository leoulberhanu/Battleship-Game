class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column

    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @board = Array.new(@max_row){Array.new(max_column)}
        @spaces_filled = 0
        @num_successful_attacks = 0
        
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)
        if ship.start_position.row > @max_row || ship.start_position.row < 1
            return false
        end
        if ship.start_position.column > @max_column || ship.start_position.column < 1
            return false
        end
        if ship.orientation == "Up"
            if ship.start_position.row - ship.size < 0
                return false
            end
            count = 0 
            while count < ship.size
                if @board[ship.start_position.row-1-count][ship.start_position.column-1] == 1
                    return false
                else
                    @board[ship.start_position.row-1-count][ship.start_position.column-1] = 1
                end
                count = count + 1
            end
            @spaces_filled = @spaces_filled + ship.size
        elsif ship.orientation == "Down"
            if ship.start_position.row + ship.size > @max_row + 1
                return false
            end
            count = 0
            while count < ship.size
                if @board[ship.start_position.row-1+count][ship.start_position.column-1] == 1
                    return false
                else
                    @board[ship.start_position.row-1+count][ship.start_position.column-1] = 1
                end
                count = count + 1
            end
            @spaces_filled = @spaces_filled + ship.size
        elsif ship.orientation == "Left"
            if ship.start_position.column - ship.size < 0 
                return false
            end
            count = 0
            while count < ship.size
                if @board[ship.start_position.row-1][ship.start_position.column-1-count] == 1
                    return false
                else
                    @board[ship.start_position.row-1][ship.start_position.column-1-count] = 1
                end
                count = count + 1
            end
            @spaces_filled = @spaces_filled + ship.size
        elsif ship.orientation == "Right"
            if ship.start_position.column + ship.size > @max_column + 1
                return false
            end
            count = 0
            while count < ship.size
                if @board[ship.start_position.row-1][ship.start_position.column-1+count] == 1
                    return false
                else
                    @board[ship.start_position.row-1][ship.start_position.column-1+count] = 1
                end
                count = count + 1
            end
            @spaces_filled = @spaces_filled + ship.size
        end    

        
        return true

    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # check position
        if position.row > max_row || position.row < 1
            return nil
        end
        if position.column > max_column || position.column < 1
            return nil
        end
        # update your grid
        if @board[position.row-1][position.column-1] == 1
            @board[position.row-1][position.column-1] = 2
            @num_successful_attacks = @num_successful_attacks + 1
            return true
        else
            @board[position.row-1][position.column-1] = -1
            return false
        end

        # return whether the attack was successful or not
    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        return @num_successful_attacks
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        if @spaces_filled == @num_successful_attacks
            return true
        else
            return false
        end
    end


    # String representation of GameBoard (optional but recommended)
    def to_s
        countrow = 1
        while countrow <= @max_row
            countcol = 1
            while countcol <= @max_column
                puts @board[countrow][countcol]
                puts " "
                countcol = countcol + 1
            end
            puts " "
            countrow = countrow + 1
        end
    end
end
