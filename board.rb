require './slidingpiece'
require './steppingpiece'
require './pawn'

class Board

  HASH_PIECES = {white: {
    king: '♔',
    queen: '♕',
    rook: '♖',
    bishop: '♗',
    knight: '♘',
    pawn: '♙'
  }, black: {
    king: '♚',
    queen: '♛',
    rook: '♜',
    bishop: '♝',
    knight: '♞',
    pawn: '♟'
  }}

  attr_reader :board

  def initialize
    @board = Array.new(8) {Array.new(8)}
  end

  def [](pos)
    x,y = pos
    @board[x][y]
  end
  def []=(pos, value)
    x, y = pos
    @board[x][y] = value
  end

  def king_position(color)
    board.each do |row|
      row.each do |piece|
        if piece && piece.piece_type == :king && piece.color == color
          return piece.position
        end
      end
    end
  end

  def in_check?(color)
    board.each do |row|
      row.each do |piece|
        if piece && piece.legal_move?(king_position(color)) #&& piece.color != color
          return true
        end
      end
    end
    false
  end

  def move(start_pos, end_pos, color)
    if self[start_pos] && self[start_pos].color == color
      self[start_pos].move(end_pos)
      self[start_pos], self[end_pos] = nil, self[start_pos]
      true
    else
      false
    end
  end

  def print_board
    board.each do |row|
      print "\n"
      row.each do |piece|
        print HASH_PIECES[piece.color][piece.piece_type] if piece
        print "_" if piece.nil?
        print " "
      end
    end

    nil
  end

  def self.starting_board
    board = Board.new

    #black pieces
    board[[0,0]] = SlidingPiece.new(board, :black, [0,0], :rook)
    board[[0,1]] = SteppingPiece.new(board, :black, [0,1], :knight)
    board[[0,2]] = SlidingPiece.new(board, :black, [0,2], :bishop)
    board[[0,3]] = SlidingPiece.new(board, :black, [0,3], :queen)
    board[[0,4]] = SteppingPiece.new(board, :black, [0,4], :king)
    board[[0,5]] = SlidingPiece.new(board, :black, [0,5], :bishop)
    board[[0,6]] = SteppingPiece.new(board, :black, [0,6], :knight)
    board[[0,7]] = SlidingPiece.new(board, :black, [0,7], :rook)

    # black pawns
    8.times do |y|
      board[[1, y]] = Pawn.new(board, :black, [1, y], :pawn)
    end

    # white pieces
    board[[7,0]] = SlidingPiece.new(board, :white, [7,0], :rook)
    board[[7,1]] = SteppingPiece.new(board, :white, [7,1], :knight)
    board[[7,2]] = SlidingPiece.new(board, :white, [7,2], :bishop)
    board[[7,3]] = SlidingPiece.new(board, :white, [7,3], :queen)
    board[[7,4]] = SteppingPiece.new(board, :white, [7,4], :king)
    board[[7,5]] = SlidingPiece.new(board, :white, [7,5], :bishop)
    board[[7,6]] = SteppingPiece.new(board, :white, [7,6], :knight)
    board[[7,7]] = SlidingPiece.new(board, :white, [7,7], :rook)

    #white pawns
    8.times do |y|
      board[[6, y]] = Pawn.new(board, :white, [6, y], :pawn)
    end

    board
  end

end