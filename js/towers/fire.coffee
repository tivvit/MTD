define ['towers/tower', 'towers/config'], (Tower, config) ->
  class Fire extends Tower
    constructor: (@x, @y)->
      @name = config.fire.name;
      @img = config.fire.img;
      @price = config.fire.price;
      @attack = config.fire.attack;
      @range = config.fire.range;
      @speed = config.fire.speed;
      @lastShot = 0;
      @shots = [];