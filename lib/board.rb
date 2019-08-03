class Board

    def self.print_grid(grid)
        grid.each do |row|
            puts row.join(" ")
        end
    end
  
    attr_reader :size 

    def initialize(n)
        # does not give you distinct array of elements
        # Array.new(n, Array.new(n))
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n * n
    end

    def [](position)
        # position = [3, 5]
        # row, col = position
        # row's value is 3, column's value is 5
        row, col = position
        @grid[row][col]
    end

    def []=(position, value)
        row, col = position 
        @grid[row][col] = value
    end

    def num_ships
        # .flatten concatenate 2D arrays together
        @grid.flatten.count { |ele| ele == :S }
    end

    def attack(position)
        if self[position] == :S
            self[position] = :H
            puts "you sunk my battleship"
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        total_ships = @size * 0.25
        while self.num_ships < total_ships
            rand_row = rand(0...@grid.length)
            rand_col = rand(0...@grid.length)
            position = [rand_row, rand_col]
            self[position] = :S
        end
    end

    def hidden_ships_grid
        @grid.map do |row|
            row.map do |ele|
                if ele == :S
                    :N
                else
                    ele
                end
            end
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        hidden_grid = self.hidden_ships_grid
        Board.print_grid(hidden_grid)
    end

end
