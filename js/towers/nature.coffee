define ['towers/tower'], (Tower) ->
  class Nature extends Tower
    constructor: (@x, @y)->
      @name = "Nature";
      @img = "img/leaf.svg";
      @price = 30;
      @attack = 2;
      @range = 4;
      @speed = 2000;
      @lastShot = 0;


#window.Nature = Nature;