define ['towers/tower'], (Tower) ->
  class Water extends Tower
    constructor: (@x, @y)->
      @name = "Water";
      @img = "img/droplet.svg"
      @price = 30;
      @attack = 2;
      @range = 4;
      @speed = 2000;
      @lastShot = 0;

#window.Water = Water;