# find the parent of the destination node with the find method
# find the parent of the parent until nil

# set the node creation smaller
# level order traversal until we find the destination
# put items into a queue
# return the all the parents from there with our find parent combo method

# possible ways
# implement a depth of moves variable?

# traverse the tree of 2 to 3,000 nodes in level order
# add every node to array in level order
# Stop adding nodes to array in level order once the destination is found
# destination node will be at end of array
# Find that destination node on the original tree, which also contains parent and array values
# find the parents of that node recursively

class Game
  attr_accessor :root

  def initialize
    @possible_moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    @root = nil
    @path = []
  end

  def knight_moves(start, destination)
    build_tree(start, destination, nodes = 0)
    print = level_order(node = @root, destination)
    move_count = print.count - 1
    puts 'knight_moves([0,0],[7,7])'
    puts "You made it in #{move_count} moves! Here's your path: "
    print.each do |square|
      p square
    end
  end

  private

  def build_tree(start, _destination, nodes = 0)
    @root = Knight.new(nil, start)
    queue = [@root]

    until queue.empty?
      current_position = queue.shift
      position_data = current_position.data

      current_position.moves = []

      @possible_moves.each do |move|
        new_position = [position_data[0] + move[0], position_data[1] + move[1]]
        next unless new_position[0].between?(0, 7) == true && new_position[1].between?(0, 7)

        # array value new_move = Knight.new(position_data, new_position, nil)
        new_move = Knight.new(current_position, new_position, nil)
        current_position.moves << new_move
        queue.push(new_move)
        nodes += 1
        return @root if nodes == 3000
        #  if new_move.data == destination
        #    return @root
        #  end
      end

    end

    @root
  end

  # Display tree in level order until destination is found
  def level_order(node = @root, destination)
    return nil if node.nil?

    move_queue = [node]
    output = []
    finish = false

    until move_queue.empty?
      current = move_queue.shift

      next if current.moves.nil?

      current.moves.each do |move|
        output << move
        # data  output << move.data
        move_queue << move unless current.moves.nil? # || move.data == destination

        if move.data == destination
          move_queue.clear
          break
        end
      end
    end

    # p output
    correct_node = output.last
    find(node = @root, correct_node)
    path = find_parent(node = @root, correct_node)
    path.unshift(destination).reverse
  end

  def find_parent(_node = @root, correct_node)
    return @path if correct_node.parent.nil?

    parent = find(node = @root, correct_node)
    @path << parent.data

    find_parent(node = @root, parent)
  end

  # Look for destination node from the end of level order traversal on the original tree
  # Returns the node from the original tree with access to array value and parent data
  def find(node = @root, correct_node)
    return nil if node.nil?

    return node.parent if correct_node == node

    return nil if node.moves.nil?

    node.moves.each do |move|
      result = find(move, correct_node)
      return result unless result.nil?
    end

    nil
  end
end

class Knight
  attr_accessor :parent, :data, :moves

  def initialize(parent = nil, data = nil, moves = nil)
    @parent = parent
    @data = data
    @moves = moves
  end
end

game = Game.new
game.knight_moves([0, 0], [7, 7])
