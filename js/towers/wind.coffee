define ['towers/tower', 'towers/config'], (Tower, config) ->
  class Wind extends Tower
    constructor: (@x, @y)->
      @name = config.wind.name;
      @img = config.wind.img;
      @price = config.wind.price;
      @attack = config.wind.attack;
      @range = config.wind.range;
      @speed = config.wind.speed;
      @lastShot = 0;
      @shots = [];

#window.Wind = Wind;