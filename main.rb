# data structure similar to a binary tree: acyclic, undirected graph
# can build root of tree from perspective knight start
# each node represents position on chess board
# potential moves as children to the root > each children has their own children
# #  BFS you're checking all possible 1-long paths then if no solution, all possible 2-long paths then all 3-long then all 4-long etc.
# You take a path, check if the end of the path is the end position. if not de-queue the path and add all the paths that the last node in that path lead to?
# implement a queue with my exisiting code
# possible moves(routes) add and substract to the desired end code: this in return mirrors a chess board
# each child has all possible moves 
# moves can not be over 7 and under 0 
# saved vertices (nodes) moved on
# there are an infinite amount of ways to get to a node, save the one that takes the least edges or nodes moved



class Game
  attr_accessor :root

  def initialize()
    @possible_moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    @root = nil
    @board_positions = []
  end

  def build_tree(start, destination, possible_moves)

    if start == destination
      return nil
    end

    if @board_positions.count == 64
      return nil
    end
    
    root = Knight.new(start)
    @board_positions.push(root.position)


    @possible_moves.each do |move|
      new_start = [root.position[0] + move[0], root.position[1] + move[1]]
      if new_start[0].between?(0, 7) == true && new_start[1].between?(0, 7) == true && @board_positions.include?(new_start) == false
        if new_start == destination
          @board_positions.push(new_start)
          root.moves = Knight.new(new_start)
          break
        else
          root.moves = build_tree(new_start, destination, possible_moves)
        end
      end 
    end

    @root = root

  end



  def knight_moves(start, destination)
    build_tree(start, destination, @possible_moves)
    p @board_positions
    p @root
  end
  

end

class Knight
attr_accessor :position, :moves


  def initialize(position)
    @position = position
    @moves = nil
  end
end

game = Game.new
game.knight_moves([0,0], [1,2])
