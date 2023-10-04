#find the parent of the destination node with the find method
# find the parent of the parent until nil

# set the node creation smaller 
# level order traversal until we find the destination
# put items into a queue
# return the all the parents from there with our find parent combo method

# possible ways
# implement a depth of moves variable?


class Game
  attr_accessor :root

  def initialize()
    @possible_moves = [[2, 1], [1, 2], [2, -1], [1, -2], [-2, 1], [-1, 2], [-2, -1], [-1, -2]]
    @root = nil
    @path = []
  end

  def build_tree(start, destination, nodes = 0)
    @root = Knight.new(nil, start)
    queue = [@root]
  

    until queue.empty?
      current_position = queue.shift
      position_data = current_position.data

      current_position.moves = []

      @possible_moves.each do |move|
        new_position = [position_data[0] + move[0], position_data[1] + move[1]]
        if new_position[0].between?(0, 7) == true && new_position[1].between?(0, 7)
          new_move = Knight.new(position_data, new_position, nil)
          current_position.moves << new_move
          queue.push(new_move)
          nodes += 1
          return @root if nodes == 4
        #  if new_move.data == destination
        #    return @root
        #  end
        end
      end

    end

    return @root
  end

  def level_order(node = @root, destination)
    return nil if node.nil?

    move_queue = [node]
    output = []
    finish = false

    until move_queue.empty?
      current = move_queue.shift

      if current.moves != nil

        current.moves.each do |move|
        output << move.data
      
        move_queue << move unless current.moves.nil?  || move.data == destination
      
        end
      end
    end
   output
  end

  #<Knight:0x00007f10ef947b98 @parent=nil, @data=[0, 0], @moves=[#<Knight:0x00007f10ef9479b8 @parent=[0, 0], @data=[2, 1], @moves=[#<Knight:0x00007f10ef947788 @parent=[2, 1], @data=[4, 2], @moves=nil>, #<Knight:0x00007f10ef947738 @parent=[2, 1], @data=[3, 3], @moves=nil>, #<Knight:0x00007f10ef9476e8 @parent=[2, 1], @data=[4, 0], @moves=nil>, #<Knight:0x00007f10ef947670 @parent=[2, 1], @data=[0, 2], @moves=nil>, #<Knight:0x00007f10ef947620 @parent=[2, 1], @data=[1, 3], @moves=nil>, #<Knight:0x00007f10ef9475d0 @parent=[2, 1], @data=[0, 0], @moves=nil>]>, #<Knight:0x00007f10ef947918 @parent=[0, 0], @data=[1, 2], @moves=nil>]>
#[[2, 1], [1, 2], [4, 2], [3, 3], [4, 0], [0, 2], [1, 3], [0, 0]]


  def find_parent (node = @root, destination)
    if destination == node.data
      return nil 
    end

    parent = find(node = @root, destination)
    @path << parent

    track_traversal(node = @root, parent)
  end

#  def find(node = @root, destination)
#    if node.nil?
#      return nil 
#    end

#    if destination == node.data
#      return node.data
#    end

#    if node.moves.nil?
#      return nil
#    end

#    node.moves.each do |move|
#      result = find(move, destination)
#      if result != nil
#        return result 
#      end
#    end

#    nil

#  end

  def depth(node = @root, counter = 0, destination)
    return -1 if node.nil?

    return counter if node.moves.nil?

    return counter if destination == node.data

    node.moves.each do |move|
      level = depth(move, counter + 1, destination)
      return level
    end

  #  counter
  end



  def knight_moves(start, destination)
    p build_tree(start, destination, nodes = 0)
    #move_count = depth(node = @root, counter = 0, destination)
    #puts "You made it in #{move_count} moves! Here's your path: "
    #p find(node = @root, destination)
    p level_order(node = @root, destination)
    #track_traversal(node = @root, destination)
    #p @path
    #path.each do |position|
    #  p position
    #end
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
game.knight_moves([0,0],[2,1])

