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
      x = Math.round(@x/@blockSize);
      y = Math.round(@y/@blockSize);
#      if x >= 20
#        x -= 20;
#      if y >= 20
#        y -=20;
      pos["x"] = x;
      pos["y"] = y;
      return pos;

#window.Enemy = Enemy;