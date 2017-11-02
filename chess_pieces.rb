class ChessPieces
  include Enumerable
  PIECES = %w{king queen bishop knight tower pawn}

  def each
    PIECES.each{|piece| yield(piece)}
  end
end