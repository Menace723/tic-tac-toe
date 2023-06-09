#create class and define the neccessary instance variables
class TicTacToe
    def initialize 
        @board = Array.new(9, ' ')
        @current_player = 'X'
        @players = {}
        @scores = { 'X' => 0, 'O' => 0}
    end

    #board method and displays 
    def draw_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "---+---+---"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "---+---+---"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    #player's name inputs
    def get_player_names
        puts "Enter Player 1's name:"
        @players['X'] = gets.chomp 

        puts "Enter Player 2's name:"
        @players['O'] = gets.chomp
    end

    #getting players' moves and validates it
    def get_move
        loop do 
            puts "#{@players[@current_player]}, please enter your move (1-9):"
            input = gets.chomp.to_i - 1

            if  input.between?(0, 8) && @board[input] == ' '
                @board[input] = @current_player
                break 
            else   
                puts "Invalid move. Please try again."
            end
        end 
    end 
    
    #switching between players
    def switch_player
        @current_player = @current_player == 'X' ? 'O' : 'X'
    end  
    
    #checks if the game is over and returns the winning player or draw
    def game_over 
        WINNING_LINES.each do |line|
            if @board[line[0]] != ' ' && @board[line[0]] == @board[line[1]] && @board[line[1]] == @board[line[2]]
                return @current_player
            end
        end
    
        if @board.all? { |cell| cell != ' '}
            return 'DRAW'
        end 
    
        nil 
    end 

    #keeping scores
    def update_scores(winner)
        @scores[winner] += 1 if winner
    end

    #display of scores
    def display_scores
        puts "Current Scores:"
        @scores.each { |player, score| puts "#{@players[player]}: #{score}"}
    end
    
    #handles game loop and displays the result
    def play 
        get_player_names
    
        loop do
            loop do 
                draw_board
                get_move
                result = game_over
        
                if result
                    draw_board
                    if result == 'DRAW'
                        puts "It's a draw!"
                    else 
                        puts "#{@players[@current_player]} wins!"
                        update_scores(@current_player)
                    end
                    display_scores
                    break
                end 
        
                switch_player
            end
            
            puts "Do you want to play again? (Y/N)"
            play_again = gets.chomp.downcase

            break unless play_again == 'y'

            reset_game
        end

        puts "Thank you for playing!"

    end

    #reseting the game
    def reset_game
        @board = Array.new(9, ' ')
        @current_player = 'X'
    end

    private
    
    #contains possible winning lines on the board
    WINNING_LINES = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8], #rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], #columns
        [0, 4, 8], [2, 4, 6] #diagonals
    ].freeze
end

#create instance for TicTacToe class and starting the game with 'play'
game = TicTacToe.new
game.play