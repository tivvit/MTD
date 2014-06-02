define ['towers/tower', 'towers/config'], (Tower, config) ->
  class Water extends Tower
    constructor: (@x, @y)->
      @name = config.water.name;
      @img = config.water.img;
      @price = config.water.price;
      @attack = config.water.attack;
      @range = config.water.range;
      @speed = config.water.speed;
      @lastShot = 0;
      @shots = [];
