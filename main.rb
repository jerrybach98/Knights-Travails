# Shows the shortest possible way a knight can get from one square to another on a chess board
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

  # Moves are created using a queue of nodes from the original position for breadth first.
  def build_tree(start, destination, nodes = 0)
    @root = Knight.new(nil, start)
    queue = [@root]

    until queue.empty?
      current_position = queue.shift
      position_data = current_position.data

      current_position.moves = []

      @possible_moves.each do |move|
        new_position = [position_data[0] + move[0], position_data[1] + move[1]]
        # Prevent out of bounds
        next unless new_position[0].between?(0, 7) == true && new_position[1].between?(0, 7)

        # Saves the children nodes in arrays
        new_move = Knight.new(current_position, new_position, nil)
        current_position.moves << new_move
        queue.push(new_move)
        nodes += 1
        # Limit for tree creation
        return @root if nodes == 4000
      end
    end

    @root
  end

  # Guarantees the minimum path to destination using level order traversal to save history of nodes traversed on.
  def level_order(node = @root, destination)
    return nil if node.nil?
    
    move_queue = [node]
    output = []
    finish = false

    until move_queue.empty?
      current = move_queue.shift

      next if current.moves.nil?

      current.moves.each do |move|
        # Stores output history of nodes traversed
        output << move
        move_queue << move unless current.moves.nil?

        # Stop traversal when destination node is added to output history
        if move.data == destination
          move_queue.clear
          break
        end
      end
    end

    # Helper functions to traverse through original tree with destination node.
    correct_node = output.last
    find_parent(node = @root, correct_node)
    path = return_parents(node = @root, correct_node)
    path.unshift(destination).reverse
  end

  # Traverses down the tree until destination node is found and output its parent data. 
  def find_parent(node = @root, correct_node)
    return nil if node.nil?

    return node.parent if correct_node == node

    return nil if node.moves.nil?

    # Recursion and each do is used as tree stores its children in heavily nested arrays.  
    node.moves.each do |move|
      result = find_parent(move, correct_node)
      return result unless result.nil?
    end

    nil
  end

 # Traverses back up tree saving parent data recursively.
  def return_parents(node = @root, correct_node)
    return @path if correct_node.parent.nil?

    parent = find_parent(node = @root, correct_node)
    @path << parent.data

    return_parents(node = @root, parent)
  end
end

# Knight is used to represent tree nodes storing the previous/current board position and possible moves as children.
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
