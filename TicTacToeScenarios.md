### User Story 1: Start the game
- **Scenario 1: Start a new game** 

    Given the player has started the application  
    When the player chooses to start a new game  
    Then the grid will be empty and have a 3x3 size  
    And the player will be able to choose to play as "X" or "O"  
    And the current turn will display "X" or "O"  
    

### User Story 2: Make a move 
- **Scenario 2: "X" makes a move**  

    Given the player has started a match  
    And the current turn is "X"  
    When the player clicks an empty box 
    Then the box will show the "X" mark  
    And the turn will change to the next player, "O" 

- **Scenario 3: "O" makes a move**  

    Given the player has started a match  
    And the current turn is "O"  
    When the player clicks an empty box 
    Then the box will show the "O" mark  
    And the turn will change to the next player, "X"  


- **Scenario 4: Move on a marked box**  

    Given the player has started a match  
    And the box (1,1) already had an "X" or "O" mark  
    When the player clicks the box (1,1)  
    Then won't be any changes and will show the error message: "The player cannot click on an occupied box".  

### User Story 3: Winner Determination
- **Scenario 5: Determining a Winner**  

    Given the player has made at least two moves  
    And the player's marks are in the same row, column, or diagonal  
    When the player makes the next move in the empty box to complete 3 consecutive marks in that row, column, or diagonal  
    Then the game must declare the player as the winner and indicate that the game has ended  

- **Scenario 6: Tie**  

    Given the players have alternated moves and all boxes are filled  
    And there are no three consecutive marks from the same player in any row, column, or diagonal  
    When the player makes the final move and all boxes are occupied  
    Then the game must declare a tie  

### User Story 4: Restarting the Game
- **Scenario 7: Restart the game** 

    Given the player has started the game  
    When the player clicks the restart button  
    Then the grid must reset to an empty state  
    And the player must be able to select again whether to play as "X" or "O"  

### User Story 5: Intuitive User Interface (UI)
- **Scenario 8: Viewing an Intuitive Interface**  

    Given the player has opened the application  
    When the player views the Tic-Tac-Toe grid  
    Then the grid must be clearly visible and have a clean design  
    And the boxes must be easily selectable  
    And the game state (current turn, victory, tie) must be clearly visible  


### User Story 6: Local Multiplayer Mode
- **Scenario 9: Playing with Another Player on the Same Device**

    Given the player has selected the local multiplayer mode  
    When both players click on boxes to place their marks  
    Then the grid must correctly display the marks for "X" and "O"  
    And the turn must alternate between players after each move  
    And the scoreboard must show the game state for both players  

### User Story 7: Playing Against the Computer (AI)
- **Scenario 10: Playing Against the AI**

    Given the player has selected to play against the computer (AI)  
    And has chosen a configurable AI difficulty level (easy, medium, or hard)  
    When the player makes a move  
    Then the AI must make a valid move on the grid  