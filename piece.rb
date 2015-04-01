class Piece
  attr_accessor :color, :board, :position, :piece_type
  def initialize(board, color, position, piece_type)
    @color = color
    @board = board
    @position = position
    @piece_type = piece_type
  end

  def move(to_position)
    #p to_position
    if legal_move?(to_position)
      if board[to_position].nil?
        #move there
        p "to_position #{to_position}"
        @position = to_position
      else
        #capture the enemy piece, and put this piece there
        @position = to_position
        capture(board[to_position])
      end
    else
      raise "Invalid move"
    end

    def inspect
      { color: @color,
        position: @position,
        piece_type: @piece_type
      }.inspect
    end
  end



  def available_square?(to_position)
    board[to_position].nil? || board[to_position].color != self.color
  end

  def on_board?(position)
    position[0].between?(0 , 7) && position[1].between?(0 , 7)

  end

  def capture(other_piece)
    print "This piece captured #{other_piece}."
  end

  def dup
    new_piece = self.class.new(board, color, position, piece_type)
  #  p new_piece.position
  end
end
# [[piece object][nil][nil][piece_object]]
