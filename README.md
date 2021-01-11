# Chess

Command line Chess game developed in Ruby.

Final project of the Ruby section of The Odin Project (https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project).

## Features

- User can play against himself or a friend
- Moves are manually selected by user, invalid moves cause the user to be prompted to choose again
- Player can save the game at any point, and load a previous game at the start of a new game
- Full test coverage with Rspec

## Screenshots 

#### Start Screen

![Screenshot_2020-08-08_12-35-17](https://user-images.githubusercontent.com/52515015/89716733-1d0cca80-d975-11ea-80ba-6a10d7d7f50c.png)


#### Gameplay

![new](https://user-images.githubusercontent.com/52515015/89716725-08c8cd80-d975-11ea-94ec-ce95b9b9c9f0.png)

## Takeaways

The primary thing I learned from this exercise was the important of following proper Object Oriented Programming practices. While I was able to hack together the chess game easy enough, it was very hard to write tests for some of the functions and classes I wrote. Unit tests were particularly challenging to write for the 'Game' class, as functions were dependent on user input and I did not stick to the Single Responsibility Principle. Comparatively, the unit tests for the basic piece movement behavior was very simple, as all the logic was contained in small, distinct classes. 

