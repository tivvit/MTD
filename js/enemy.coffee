define ->
  class Enemy
    constructor: (@x, @y, @blockSize, @gridSize)->
      @name = "Enemy";
      @lives = 5;
      @speed = .08;
      @lastAnimated;

    draw: (@ctx) ->
      now = new Date().getTime();
      dt = now - (@lastAnimated || now);

      @lastAnimated = now;
      @x += @speed * dt;
      image = new Image();
      image.src = "img/alien.png";
  #    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

    position: ->
      pos = {};
      pos["x"] = Math.round(@x/@blockSize);
      pos["y"] = Math.round(@y/@blockSize);
      return pos;

#window.Enemy = Enemy;