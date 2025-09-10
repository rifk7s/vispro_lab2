import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  // Flowchart implementation
  String letterSpace = ""; // LetterSpace = ("")
  int letterUsed = 0; // Letter used = 0
  int lives = 6;
  int LoopCheck = 0;
  
  // Random word selection
  List<String> words = ['DART', 'CODE', 'GAME', 'PLAY', 'WORD'];
  Random random = Random();
  String randomWord = words[random.nextInt(words.length)];
  
  print('Random word selected (hidden): ${randomWord.replaceAll(RegExp(r'.'), '*')}');

  // Welcome message and user input
  print('Welcome to hangman lets start playing');
  print('Press Enter to continue...');
  stdin.readLineSync();
  
  print('LetterSpace initialized: "$letterSpace"');
  print('Letter used initialized: $letterUsed');
  print('Lives: $lives');
  print('Loop check: $LoopCheck');
  
  // Main game loop
  hangmanGame(letterSpace, letterUsed, lives, LoopCheck, randomWord);
}

void hangmanGame(String letterSpace, int letterUsed, int lives, int loopCheck, String randomWord) {
  List<String> guessedLetters = [];
  String joinedLetterGuess = "";
  
  // Main game loop: while joined letter guess != random word AND lives > 0
  while (joinedLetterGuess != randomWord && lives > 0) {
    print('\n=== Hangman Game ===');
    print('Word: ${getDisplayWord(randomWord, guessedLetters)}');
    print('Lives remaining: $lives');
    print('Guessed letters: ${guessedLetters.join(', ')}');
    
    // Get user input
    print('\nEnter a letter guess:');
    String? userInput = stdin.readLineSync();
    
    if (userInput == null || userInput.isEmpty) {
      print('Please enter a letter!');
      continue;
    }
    
    // Check if the length of user input = 1 (one letter)
    if (userInput.length != 1) {
      print('One letter at a time please try again');
      continue;
    }
    
    // Check if input is a valid letter (A-Z or a-z)
    if (!isValidLetter(userInput)) {
      print('Karakter tidak benar! Silakan masukkan huruf yang benar (A-Z).');
      continue;
    }
    
    String letterGuess = userInput.toUpperCase();
    
    // Check if user input != LetterSpace (if letter already guessed)
    if (guessedLetters.contains(letterGuess)) {
      print('You already chose this letter, try another one.');
      continue;
    }
    
    // Add letter to guessed letters
    guessedLetters.add(letterGuess);
    letterUsed++;
    
    // Check if letter is in the word
    if (randomWord.contains(letterGuess)) {
      print('Good guess! "$letterGuess" is in the word.');
    } else {
      print('Sorry, "$letterGuess" is not in the word.');
      lives--;
    }
    
    // Update joined letter guess (check if word is complete)
    joinedLetterGuess = getJoinedGuess(randomWord, guessedLetters);
  }
  
  // Game end conditions
  if (joinedLetterGuess == randomWord) {
    print('\n🎉 Congratulations! You won!');
    print('The word was: $randomWord');
  } else if (lives <= 0) {
    print('\n💀 Game Over! You ran out of lives.');
    print('The word was: $randomWord');
  }
}

String getDisplayWord(String word, List<String> guessedLetters) {
  String display = '';
  for (int i = 0; i < word.length; i++) {
    if (guessedLetters.contains(word[i])) {
      display += word[i] + ' ';
    } else {
      display += '_ ';
    }
  }
  return display.trim();
}

String getJoinedGuess(String word, List<String> guessedLetters) {
  String joined = '';
  for (int i = 0; i < word.length; i++) {
    if (guessedLetters.contains(word[i])) {
      joined += word[i];
    }
  }
  return joined.length == word.length ? word : '';
}

bool isValidLetter(String input) {
  // Check if input is a single letter (A-Z or a-z)
  if (input.length != 1) return false;
  
  int charCode = input.codeUnitAt(0);
  // Check if it's uppercase (A-Z: 65-90) or lowercase (a-z: 97-122)
  return (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122);
}




