module Mastermind
  class Game
    def initialize(messenger)
      @messenger = messenger
    end
    
    def start(code)
      @code = code
      @messenger.puts "Welcome to Mastermind!"
      @messenger.puts "Enter guess:"
    end
    
    def guess(guess)
      result = [nil,nil,nil,nil]
      guess = guess.join.scan(/./)
      guess.each_with_index do |peg,index|
        if @code[index]==peg
          result[index] = "b"
        elsif @code.include?(peg)
          result[@code.index(peg)] ||= "w"
        end
      end
      @messenger.puts result.compact.sort.join
    end
  end
end