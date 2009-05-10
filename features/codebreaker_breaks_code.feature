Feature: break the code

  When the code-breaker guesses correctly,
  the game is over and provides a congratulatory
  message including how many guesses it took
  to break the code.
  
  Scenario: break the code on the 1st guess
    Given the secret code is r g y b
    When I guess r g y b
    Then the game should be over
    And I should see the message "Congratulations! You broke the code in 1 guess."
    And I should see the message "Play again? (y|n)"
    
  Scenario: break the code on the 2nd guess
    When the secret code is r g y b
    When I guess r g y c
    And I guess r g y b
    Then the game should be over
    And I should see the message "Congratulations! You broke the code in 2 guesses."
    And I should see the message "Play again? (y|n)"

  Scenario Outline: break the code on 3 or more guesses
    When I break the code in <correct_guess> guesses
    Then the game should be over
    And  I should see the message "You broke the code in <correct_guess> guesses."
    
  Scenarios:
    | correct_guess | message |
    |           4   | You broke the code in 4 guesses.  |
    |           7   | You broke the code in 7 guesses.  |
    |          10   | You broke the code in 10 guesses. |
    
  Scenario: fail to break the code in 10 guesses
    Given the secret code is r g y b
    When I guess incorrectly 10 times
    Then the game should be over
    And I should see the message "Sorry! You didn't break the code in 10 guesses. Game Over."
    And I should see the message "Play again? (y|n)"
  
  Scenario: end game
    Given the game is over
    And I should see the message "Play again? (y|n)"
    And I choose n
    Then I should not see the message "Welcome to Mastermind!" again
    
  Scenario: play again
    Given the secret code is r g y b
    When I guess r g y b
    Then the game should be over
    And I should see the message "Play again? (y|n)"
    And I choose y
    Then the game should say "Welcome to Mastermind!"
    And the game should say "Enter guess:" 
  
 