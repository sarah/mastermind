require File.join(File.dirname(__FILE__), "/../spec_helper")

module Mastermind
  describe Game do
    before(:each) do
      @messenger = mock("messenger").as_null_object
      @game = Game.new(@messenger)
    end
    
    context "starting up" do
      it "should send a welcome message" do
        @messenger.should_receive(:puts).with("Welcome to Mastermind!")
        @game.start(%w[r g y c])
      end
      
      it "should prompt for the first guess" do
        @messenger.should_receive(:puts).with("Enter guess:")
        @game.start(%w[r g y c])
      end
      
      it "should know that 0 guesses have been made so far" do
        @game.start(%w[r g y c])
        @game.guess_count.should == 0
      end
    end
    
    context "finishing" do
      context "code guessed successfully" do
        it "should know that the game is over when you have matched the code" do
          @game.start(%w[r g y c])
          @game.guess(%w[r g y c])
          @game.should be_over        
        end
        
        it "should know many guesses I used to crack the code" do
          @game.start(%w[r g y c])
          10.times do |i|
            guess_num = i+1
            @game.guess(%w[r g y c])
            @game.guess_count.should == guess_num
          end
          @game.guess_count.should == 10
        end
        
        it "should send a congratulations message when you crack the code on the first guess" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with(/Congratulations!/)
          @game.guess(%w[r g y c])
        end
        
        it "should set the game to 'over' and stop the game after 10 unsuccessful guesses" do
          @game.start(%w[r g y c])
          10.times do |i|
            @game.guess(%w(g y c r))
          end
          @game.should_not be_won
          @game.should be_over
        end
        
        # redundant spec to feature? 
        it "should ask me if I want to play again when the game is done" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with(/Play again/)
          
          @game.guess(%w[r g y c])
          @game.should be_over        
        end
      end
    end

    context "marking a guess" do      
      context "with all 4 colors correct in the correct places" do
        it "should mark the guess with bbbb" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with("bbbb")
          @game.guess(%w[r g y c])
        end
      end

      context "with all 4 colors correct and 2 in the correct places" do
        it "should mark the guess with bbww" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with("bbww")
          @game.guess(%w[r g c y])
        end
      end
      
      context "with all 4 colors correct and 1 in the correct place" do
        it "should makr the guess with bwwww" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with("bwww")
          @game.guess(%w[y r g c])
        end
      end

      context "with three colors correct in the correct places" do
        it "should mark the guess with bbb" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with("bbb")
          @game.guess(%w[r g y w])
        end
      end

      context "with duplicates in the guess that match a peg in the code" do
        context "by color and position" do
          it "should add a single b to the mark" do
            @game.start(%w[r y g c])
            @messenger.should_receive(:puts).with("bbb")          
            @game.guess(%w(r y g g))
          end
        end
      end
      
      context "submitting answers with no spaces between the letters" do
        it "should give the same answers that it does for a guess with spaces" do
          @game.start(%w[r g y c])
          @messenger.should_receive(:puts).with("bbbb")
          @game.guess(%w[rgyc])
        end
      end
      
    end
    
  end
end