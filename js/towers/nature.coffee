define ['towers/tower', 'towers/config'], (Tower, config) ->
  class Nature extends Tower
    constructor: (@x, @y)->
      @name = "Nature";
      @img = "img/leaf.svg";
      @price = config.nature.price;
      @attack = config.nature.attack;
      @range = config.nature.range;
      @speed = config.nature.speed;
      @lastShot = 0;
      @shots = []


#window.Nature = Nature;