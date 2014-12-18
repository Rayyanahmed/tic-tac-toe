def draw_board(b)
system 'clear'
puts " #b{[0]}     #{b[1]}    #{b[2]}  "
puts ""
puts " #{b[3]}     #{b[4]}    #{b[5]}  "
puts ""
puts " #{b[6]}     #{b[7]}    #{b[8]}  "
end

board = [0,1,2,3,4,5,6,7,8]

def player_picks_square(board)
  puts "Choose an empty square(0-8)"
  position = gets.chomp.to_i
  i = 1
  while i > 0
    if position > 8
      puts "You have picked a number above this range, please pick a square (0-8)"
      position = gets.chomp.to_i
    elsif board[position] == "X" || board[position] == "O"
      puts "Please pick an EMPTY square"
      position = gets.chomp.to_i
    else
      board[position] = "X"
      break
    end
  end
end



 def computer_picks_square(board)
  win = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  i = 0
  empty = []
  while i < win.length
    winning = win[i]
    x = 0
    o = 0
    j = 0
    while j < winning.length
      if board[winning[j]] == "X"
        x = x + 1             
      elsif board[winning[j]] == "O"
        o = o + 1
      elsif board[winning[j]] != "O" && board[winning[j]] != "X"
       possible_move = winning[j]
       empty << winning[j]
      end
      j = j + 1
    end
    if o == 2 && x == 0
      return board[possible_move] = "O" ## Return is important, didn't have it before, allows us to exit out of method
    elsif x == 2 && o == 0           
      return board[possible_move] = "O" # Switched these two conditions, if attainable want to go for the win first. 
    end                             # I identified a problem, I realized order doesnt matter. Because winning conditions
    i = i + 1                       # are random and I noticed, sometimes computer will go for win, other times computer
  end                               # will play defensively. Why is that? duh. Because I may come across an defense 
  if empty.length > 0
      return board[empty.sample] = "O"
  end
end
        
def full_board?(board)
  i = 0
  count = 0
  while i < board.length
    if board[i] == "X" || board[i] == "O"
      count = count + 1
    end
    i = i + 1
  end
  count == board.length
end

def winning_condition(board)
  win = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  i = 0
  while i < win.length
    winning = win[i]
    j = 0
    x = 0
    o = 0
    while j < winning.length
      if board[winning[j]] == "X"
        x = x + 1
        if x == 3
          return "PLAYER"
        end
      elsif board[winning[j]] == "O"
        o = o + 1
        if o == 3
          return "COMPUTER"
        end
      end
      j = j + 1
    end
    i = i + 1
  end
end

def play_again?
  puts "Do you want to play again? (y/n)"
  play_again = gets.chomp
  if play_again == "y"
    return true
  elsif play_again == "n"
    return false
  end
end
        
while true
  if winning_condition(board) == "PLAYER"
    puts "Congradulations! You beat the Computer"
    break
  elsif winning_condition(board) == "COMPUTER"
    puts "SORRY, looks like you lost!"
    break
  elsif full_board?(board)
    puts "You and the computer tied."
    break
  end
  draw_board(board)
  player_picks_square(board)
  draw_board(board)
  computer_picks_square(board)
  draw_board(board)
end 
  