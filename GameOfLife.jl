# ------------------------------------------------------------------------
# Julia implementation of Conway's Game of Life [Cellular Automaton]
# ------------------------------------------------------------------------

const STEPS = 5

# ------------------------------------------------------------------------
# Function to show grids per generate steps
function showGrid(grid)
    println()
    # Print each line of grid
    for r in eachrow(grid)
        for i in r
            if i == 1
                print("# ")
            else
                print(". ")
            end
        end
        print("\n")
    end
    println()
end
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# A function to count the live neighbours of a cell
function countNeighbours((x, y), grid)
    n = 0
    for i in -1:1
        for j in -1:1
            if i == 0 && j == 0 # center cell ignored
                continue
            elseif x + i < 1 || y + j < 1 # out of bound
                continue
            elseif x + i > size(grid, 1) || y + j > size(grid, 2)
                continue
            elseif grid[x+i, y+j] == 1 # valid (check alive)
                n += 1
            end
        end
    end
    return n
end
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
# A recursive function that runs the game of life. Args of grid, steps
function conwaysLife(grid, steps)

    # Base Condition : Break on end
    if steps <= 0
        return
    end

    newgrid = Array{Int}(undef, size(grid)) # Create new grid to avoid conflict

    for x in 1:size(grid, 1) # Apply rules
        for y in 1:size(grid, 2)

            # Find live neighbours
            liveNeighbours = countNeighbours((x, y), grid)

            # Cell survives if it has 2 or 3 neighbours
            if grid[x, y] == 1 && (liveNeighbours == 2 || liveNeighbours == 3)
                newgrid[x, y] = 1

                # Born Cell : is born if it has 3 live neighbours
            elseif grid[x, y] == 0 && liveNeighbours == 3
                newgrid[x, y] = 1

                # Otherwise the cell is dead. Combines several rules into this one
            else
                newgrid[x, y] = 0
            end
        end
    end

    # displays grid
    showGrid(newgrid)

    # recursive call to continue
    conwaysLife(newgrid, steps - 1)

end
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
# A recursive function that runs the game of life.
function GameOfLife(grid)
    conwaysLife(grid, STEPS)
end
# ------------------------------------------------------------------------


# ------------------------------------------------------------------------
#= 
Many different types of patterns occur in the Game of Life, 
which are classified according to their behaviour. 
Common pattern types include: 
Still Lifes -> which do not change from one generation to the next;
Oscillators -> which return to their initial state after a finite number of generations; 
Spaceships  -> which translate themselves across the grid. 
=#
# ------------------------------------------------------------------------

# --------------------------------------
# Still lifes
# --------------------------------------
block = [
    0 0 0 0
    0 1 1 0
    0 1 1 0
    0 0 0 0]

beehive = [
    0 0 0 0 0 0
    0 0 1 1 0 0
    0 1 0 0 1 0
    0 0 1 1 0 0
    0 0 0 0 0 0]

loaf = [
    0 0 0 0 0 0
    0 0 1 1 0 0
    0 1 0 0 1 0
    0 0 1 0 1 0
    0 0 0 1 0 0
    0 0 0 0 0 0]

boat = [
    0 0 0 0 0
    0 1 1 0 0
    0 1 0 1 0
    0 0 1 0 0
    0 0 0 0 0]

tub = [
    0 0 0 0 0
    0 0 1 0 0
    0 1 0 1 0
    0 0 1 0 0
    0 0 0 0 0]

# --------------------------------------
# Oscillators
# --------------------------------------
# (period 2)
blinker = [
    0 0 0 0 0
    0 0 0 0 0
    0 1 1 1 0
    0 0 0 0 0
    0 0 0 0 0]

# (period 2)
toad = [
    0 0 0 0 0 0
    0 0 0 0 0 0
    0 0 1 1 1 0
    0 1 1 1 0 0
    0 0 0 0 0 0
    0 0 0 0 0 0]

# (period 2)
beacon = [
    0 0 0 0 0 0
    0 1 1 0 0 0
    0 1 1 0 0 0
    0 0 0 1 1 0
    0 0 0 1 1 0
    0 0 0 0 0 0]

# (period 3)
pulsar = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0
    0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 0
    0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 0
    0 0 0 0 1 0 1 0 1 0 1 0 1 0 1 0 0 0 0 0
    0 0 1 1 1 0 0 1 1 0 1 1 0 0 1 1 1 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]

# --------------------------------------
# Spaceships
# --------------------------------------
glider = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]

lightweightSpaceShip = [
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 1 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]

# --------------------------------------
# Predefined Patterns
# --------------------------------------
pattern1 = [
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 1 0 0 0 0 0 0 0 0
    0 0 0 0 0 1 1 0 0 0 0 0 0
    0 0 0 0 0 1 0 1 0 0 0 0 0
    0 0 0 0 0 0 1 1 0 0 0 0 0
    0 0 0 0 0 0 0 0 1 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
]

pattern2 = [
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 1 1 1 1 1 0 0 0 0
    0 0 0 0 1 0 0 0 1 0 0 0 0
    0 0 0 0 1 0 1 0 1 0 0 0 0
    0 0 0 0 1 0 0 0 1 0 0 0 0
    0 0 0 0 1 1 1 1 1 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0
]

# ------------------------------------------------------------------------


function main()
    println("\n")
    while true
        println("Choose a pattern type : \n")
        println("1. Still Lifes ")
        println("2. Oscillators  ")
        println("3. Spaceships ")
        println("4. Other Predefined Patterns ")
        # reads choice from user
        s = readline()
        # breaks the while loop
        if s == "0"
            println("\nEXITING PROGRAM..\n")
            break
        end
        # ----------------------------------------
        if s == "1"
            println("Choose a Still Lifes pattern to generate : \n")
            println("1. block ")
            showGrid(block)
            println("2. beehive  ")
            showGrid(beehive)
            println("3. loaf ")
            showGrid(loaf)
            println("4. boat ")
            showGrid(boat)
            println("5. tub ")
            showGrid(tub)
            # reads choice from user
            c = readline()
            # ----------------
            if c == "1"
                println("--------------------------------------")
                GameOfLife(block)
            end
            if c == "2"
                println("--------------------------------------")
                GameOfLife(beehive)
            end
            if c == "3"
                println("--------------------------------------")
                GameOfLife(loaf)
            end
            if c == "4"
                println("--------------------------------------")
                GameOfLife(boat)
            end
            if c == "5"
                println("--------------------------------------")
                GameOfLife(tub)
            end
        end
        # ----------------------------------------
        if s == "2"
            println("Choose an Oscillators pattern to generate : \n")
            println("1. blinker (period 2) ")
            showGrid(blinker)
            println("2. toad (period 2)  ")
            showGrid(toad)
            println("3. beacon (period 2) ")
            showGrid(beacon)
            println("4. pulsar (period 3) ")
            showGrid(pulsar)
            # reads choice from user
            c = readline()
            # ----------------
            if c == "1"
                println("--------------------------------------")
                GameOfLife(blinker)
            end
            if c == "2"
                println("--------------------------------------")
                GameOfLife(toad)
            end
            if c == "3"
                println("--------------------------------------")
                GameOfLife(beacon)
            end
            if c == "4"
                println("--------------------------------------")
                GameOfLife(pulsar)
            end
        end
        # ----------------------------------------
        if s == "3"
            println("Choose a Spaceships pattern to generate : \n")
            println("1. glider ")
            showGrid(glider)
            println("2. lightweight spaceship  ")
            showGrid(lightweightSpaceShip)
            # reads choice from user
            c = readline()
            # ----------------
            if c == "1"
                println("--------------------------------------")
                GameOfLife(glider)
            end
            if c == "2"
                println("--------------------------------------")
                GameOfLife(lightweightSpaceShip)
            end
        end
        # ----------------------------------------
        if s == "4"
            println("Choose a predefined pattern to generate : \n")
            println("Predefined Patterns -> \n")
            println("1. Pattern 1 ")
            showGrid(pattern1)
            println("2. Pattern 2 ")
            showGrid(pattern2)
            # reads choice from user
            c = readline()
            # ----------------
            if c == "1"
                println("--------------------------------------")
                GameOfLife(pattern1)
            end
            if c == "2"
                println("--------------------------------------")
                GameOfLife(pattern2)
            end

        end
        println("--------------------------------------")
    end
end


# RUN THE MAIN PROGRAM
main()