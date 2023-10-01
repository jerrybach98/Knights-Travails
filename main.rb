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
# make [2, 1], [1, 2] children of 0, 0 to both equal nil

# pass the actual node?




class Game
  attr_accessor :root

  def initialize()
    @possible_moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    @root = nil
  end

  def build_tree(start, destination)
    @root = Knight.new(start, nil)
    queue = [@root]

    until queue.empty?
      current_position = queue.shift
      position_data = current_position.data

      current_position.moves = []

      @possible_moves.each do |move|
        new_position = [position_data[0] + move[0], position_data[1] + move[1]]
        if new_position[0].between?(0, 7) == true && new_position[1].between?(0, 7)
          new_move = Knight.new(new_position, nil)
          current_position.moves << new_move
          queue.push(new_move)
          if new_position == destination
            return @root
          end
        end
      end

    end

    return @root
  end

  def track_traversal(node = @root, destination)
    return nil if node.nil?

    queue = [node]
    output = []
    until queue.empty?
      # Pull node out of queue to process children and value
      current = queue.shift
      output << current.data
      
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    output
  end

  def find(node = @root, destination)
    return false if node.nil?

    return if node.moves.nil?

    return if destination == node.data

    node.moves.each do |move|
      result = find(move, destination)
      return true if result
    end
  end

  def depth(node = @root, counter = 0, destination)
    return -1 if node.nil?

    return counter if node.moves.nil?

    return counter if node.data == destination

    node.moves.each do |move|
      level = depth(move, counter + 1, destination)
      return level
    end

    counter
  end

  



  def knight_moves(start, destination)
    p build_tree(start, destination)
    p find(node = @root, destination)
    #p track_traversal(node = @root, destination)
    p depth(node = @root, counter = 0, destination)
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
game.knight_moves([0,0],[9,9])
