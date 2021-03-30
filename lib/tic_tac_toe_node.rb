require_relative 'tic_tac_toe'


class TicTacToeNode

  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.board.over?
      # self.board.winner == evaluator ? (return false) : (return true)
      return board.won? && board.winner != evaluator
    end

    if evaluator == @next_mover_mark
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end

  end

  def winning_node?(evaluator)
    if self.board.over?
      self.board.winner == evaluator ? (return true) : (return false)
    end

    if evaluator == @next_mover_mark
      self.children.any? { |child| child.winning_node?(evaluator) }
    else
      self.children.all? { |child| child.winning_node?(evaluator) }
    end
    
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |row|
      (0..2).each do |child|
        if @board.empty?([row, child])
          dup = @board.dup
          @next_mover_mark == :o ? (mark = :x) : (mark = :o)
          dup[[row, child]] = @next_mover_mark
          node = TicTacToeNode.new(dup, mark, [row, child])
          children << node
        end
      end
    end
    children
  end


end
