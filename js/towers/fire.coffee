define ['towers/tower', 'towers/config'], (Tower, config) ->
  class Fire extends Tower
    constructor: (@x, @y)->
      @name = "Fire";
      @img = "img/fire.svg";
      @price = config.fire.price;
      @attack = config.fire.attack;
      @range = config.fire.range;
      @speed = config.fire.speed;
      @lastShot = 0;
      @shots = [];


#  window.Fire = Fire;