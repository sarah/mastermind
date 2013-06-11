module Mastermind
  class Game
    
    attr_accessor :guess_count
    
    def initialize(messenger)
      @messenger = messenger
    end
    
    def start(code)
      @code = code
      @guess_count = 0
      @messenger.puts "Welcome to Mastermind!"
      @messenger.puts "Enter guess:"
    end
    
    def guess(guess)
      @guess_count += 1
      result = [nil,nil,nil,nil]
      @guess = guess.join.scan(/./)
      @guess.each_with_index do |peg,index|
        if @code[index]==peg
          result[index] = "b"
        elsif @code.include?(peg)
          result[@code.index(peg)] ||= "w"
        end
      end
      @messenger.puts result.compact.sort.join
      if over?
        @messenger.puts game_over_message 
        @messenger.puts "Play again? (y|n)"
      end
    end
    
    def game_over_message
      message = "You broke the code in #{@guess_count} guesses."
      case @guess_count
        when 1 
          "Congratulations! You broke the code in #{@guess_count} guess."
        when 2 
          "Congratulations! #{message}"
        when 10 
          won?  ? message : "Sorry! You didn't break the code in 10 guesses. Game Over."
        else  
          message
      end      
    end
 
    def won? 
      @guess == @code
    end
    
    def over?
      won? || @guess_count == 10 
    end
  
  end
end
