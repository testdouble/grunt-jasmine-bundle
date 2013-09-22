GumballMachine = require("./../../lib/gumball-machine")
NullGumball = require("./../../lib/null-gumball")

describe "GumballMachine", ->
  Given -> @subject = new GumballMachine

  describe "#dispense", ->
    context "less than 25 cents", ->
      When -> @result = @subject.dispense(24)
      Then -> @result instanceof NullGumball

    context "exactly 25 cents", ->
      When -> @result = @subject.dispense(25)
      Then -> expect(@result).toHaveFlavor()
