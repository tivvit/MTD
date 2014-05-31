define ['towers/tower'], (Tower) ->
  class Fire extends Tower
    constructor: (@x, @y)->
      @name = "Fire";
      @img = "img/fire.svg";
      @price = 30;
      @attack = 2;
      @range = 4;
      @speed = 3;

#  window.Fire = Fire;