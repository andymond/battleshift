# BattleShift ReadMe

* Ruby version

2.4.1

* Configuration

Clone this down using `git clone https://github.com/andymond/battleshift.git`

Run `bundle`

* Database creation

Run `rails db:setup`

* How to run the test suite

Run `rails db:test:prepare`

Run `rspec`

Open up a local server using `rails s`

To play you'll need to be able send a POST request to the proper api endpoint to shoot at another player.

Take a look at the routes file to learn the proper endpoints to play.

We recommend using PostMan or a similar API development environment.
