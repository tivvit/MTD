define ['towers/tower', 'towers/config'], (Tower, config) ->
  class Wind extends Tower
    constructor: (@x, @y)->
      @name = "Wind";
      @img = "img/twister.svg";
      @price = config.wind.price;
      @attack = config.wind.attack;
      @range = config.wind.range;
      @speed = config.wind.speed;
      @lastShot = 0;
      @shots = [];

#window.Wind = Wind;