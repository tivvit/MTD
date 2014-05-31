class Fire
  constructor: ->
    @name = "Fire";
    @price = 30;
    @attack = 2;
    @range = 4;
    @speed = 3;

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/fire.svg";
#    image.onload = =>
    @ctx.drawImage(image,@x, @y, 30, 30);

window.Fire = Fire;