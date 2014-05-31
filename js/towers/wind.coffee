define ['towers/tower'], (Tower) ->
  class Wind extends Tower
    constructor: (@x, @y)->
      @name = "Wind";
      @img = "img/twister.svg";
      @price = 30;
      @attack = 2;
      @range = 4;
      @speed = 3;

#window.Wind = Wind;