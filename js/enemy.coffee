class Enemy
  constructor: (@x, @y, @blockSize, @gridSize)->
  @name = "Enemy";
  @lives = 5;
  @speed = 3;

  draw: (@ctx) ->
    image = new Image();
    image.src = "img/alien.png";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

  position: ->
    return {"x": Math.round(@x / @blockSize), "y": Math.round(@y / @blockSize)};

window.Enemy = Enemy;