# data structure similar to a binary tree: acyclic, undirected graph
# can build root of tree from perspective knight start
# each node represents position on chess board
# potential moves as children to the root > each children has their own children
# possible moves(routes) add and substract to the desired end code: this in return mirrors a chess board
# each child has all possible moves 
# moves can not be over 7 and under 0 
# saved vertices (nodes) moved on
# there are an infinite amount of ways to get to a node, save the one that takes the least edges or nodes moved




# BFS you're checking all possible 1-long paths then if no solution, all possible 2-long paths then all 3-long then all 4-long etc.
# until the queue is empty
# add start to queue
# current_move = remove from queue for further analysis 
# try each possible move on removed queue node
# add moves to queue with answer between 0  - 7


# track node by going in reverse order, go from destination node to parent


# if 1 path doesn't work, clear the queue,
# path 1 should equal = [2, 1], [1, 2]
# start by making 0,0 the root 
# make [2, 1], [1, 2] children of 0, 0



class Game
  attr_accessor :root

  def initialize()
    @possible_moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    @root = nil
    @queue = []
  end

  def build_tree(start, destination, possible_moves)
    @root = Knight.new(start, nil)
    @queue.push(root.data)

    if start == destination
      return root.data
    end

    until @queue.empty?
      p @queue
      current_position = @queue.shift
      break if @queue.include?(destination)

      @possible_moves.each do |move|
        new_position = [current_position[0] + move[0], current_position[1] + move[1]]
        if new_position[0].between?(0, 7) == true && new_position[1].between?(0, 7)
          current_node = @root
          current_node = current_node.moves until current_node.moves.nil?
          current_node.moves = Knight.new(new_position, nil)
          @queue.push(current_node.moves.data)
        end
      end

     # break if current_position == destination
    end

    p @root
    return current_position
  end



  def knight_moves(start, destination)
    p build_tree(start, destination, @possible_moves)
  end
  

end

class Knight
attr_accessor :data, :moves


  def initialize(data = nil, moves = nil)
    @data = data
    @moves = moves
  end
end

game = Game.new
game.knight_moves([0,0], [1,2])
