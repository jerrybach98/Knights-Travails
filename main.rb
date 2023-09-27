# build the root, root is kngiht moves input value



# data structure similar to a binary tree: acyclic, undirected graph
# can build tree from perspective knight and some from board
# starting point of knight is root of tree


# each node represents position on chess board
# potential moves as children to the root > each children has their own children
# used a breadth first approach for shortest path
# saved vertices (nodes) moved on
# there are an infinite amount of ways to get to a node, save the one that takes the least edges or nodes moved

# possible moves(routes) add and substract to the desired end code: this in return mirrors a chess board (leetcode algorithm)
# each child has all possible moves 

# moves can not be over 7 and under 0 
# implement possible moves as children if they don't bring x and y under 0 or over 7




class Game
  attr_accessor :root

  def initialize()
    possible_moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    @root = build_tree(possible_moves)
  end

  def build_tree(start, possible_moves)
    #return nil if array.length == 0 between != 0 and 7

    root = Knight.new(start)

    # for each node, new variable root.moves = build_tree()
    possible_moves.map {|v| [@root[0] + v[0], @root[1] + v[1]]}
      
        
        
        start[0] < 0 || start[0] > 8 || start[1] < 0 || start[1] > 8
        move_results << new_position
      end
    end



    root.moves = Knight.new(
      # 
      #
      #
    )

  end


  def knight_moves(start, end)
    build_tree(start, possible_moves)
  end
  

end

class Knight
attr_accessor :position, :moves


  def initialize(position)
    @posiion = position
    @moves = nil
  end
end

game = Game.new
#knight_moves([3,3],[4,3])