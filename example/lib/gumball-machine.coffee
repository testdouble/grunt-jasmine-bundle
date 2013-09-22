Gumball = require("./gumball")
NullGumball = require("./null-gumball")

class GumballMachine
  dispense: (cents) ->
    if cents >= 25
      new Gumball
    else
      new NullGumball

module.exports = GumballMachine
