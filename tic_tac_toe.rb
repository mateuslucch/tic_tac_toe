class Board
  def boardReset(resetVal)
    @cell = resetVal
  end

  #print board
  def showBoard
    puts ""
    puts " #{@cell[0]} | #{@cell[1]} | #{@cell[2]} "
    puts " #{@cell[3]} | #{@cell[4]} | #{@cell[5]} "
    puts " #{@cell[6]} | #{@cell[7]} | #{@cell[8]} "
    puts ""
  end

  def gameChoice(choice, markSymbol)
    @choice = choice
    @markSymbol = markSymbol
    boardUpdate()
  end

  def boardUpdate
    @cell[@choice - 1] = @markSymbol
    system "clear"
    showBoard()
  end

  #game test
  def testResult
    if @cell[0] == @cell[1] && @cell[1] == @cell[2] || #line 1
       @cell[3] == @cell[4] && @cell[4] == @cell[5] || #line 2
       @cell[6] == @cell[7] && @cell[7] == @cell[8] || #line 3
       @cell[0] == @cell[3] && @cell[3] == @cell[6] || #column 1
       @cell[1] == @cell[4] && @cell[4] == @cell[7] || #column 2
       @cell[2] == @cell[5] && @cell[5] == @cell[8] || #column 3
       @cell[0] == @cell[4] && @cell[4] == @cell[8] || #main diagonal
       @cell[6] == @cell[4] && @cell[4] == @cell[2] #secondary diagonal
      return "winner"
    elsif !@cell.any? { |i| i.is_a?(Integer) } #test if there is still numbers, if not, all cells were marked and theres is no winner(first if failed)
      return "tie"
    end
  end
end #board class end

class Game
  #game menu
  def startGame()
    puts " "
    puts "Welcome to Tic-Tac-Toe!!"
    puts "(1) Start game"
    puts "(2) Exit game"
    print "=> "
    gameChoice = gets.chomp
    if gameChoice == "1"
      gameRun()
      resetGame()
    elsif gameChoice == "2"
      exit!
    else
      puts "Invalid option!!"
      startGame()
    end
  end

  def resetGame()
    @board = Board.new
    system "clear"
    gameRunning = true
    @resetVal = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    puts "Game started!!"

    @board.boardReset(@resetVal)
    @board.showBoard()
  end

  def gameRun
    gameRunning = true
    resetGame()

    def playerPlay(player, mark)
      puts "#{player} (#{mark}) choose a number in the board:"
      choice = gets.chomp

      if choice >= "1" && choice <= "9"
        choice = choice.to_i #selfnotes: remember to convert input=string to another variable
        if @resetVal[choice - 1] == "X" || @resetVal[choice - 1] == "O"
          puts "Space already marked. Choose another one!"
          playerPlay(player, mark)
        else
          @board.gameChoice(choice, mark)
        end
      else
        puts "Invalid option!! Choose again."
        playerPlay(player, mark)
      end
    end

    def resultGame(player)
      if @board.testResult() == "winner"
        puts " "
        puts "#{player} won!!!"
        puts " "
        gameRunning = false
        startGame()
      elsif @board.testResult() == "tie"
        puts " "
        puts "It´s a tie!!"
        puts " "
        gameRunning = false
        startGame()
      end
    end

    while gameRunning == true
      playerPlay("Player 1", "X")
      resultGame("Player 1")

      playerPlay("Player 2", "O")
      resultGame("Player 2")
    end
  end
end

game = Game.new
game.startGame()
