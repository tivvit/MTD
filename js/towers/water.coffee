class Water
  constructor: ->
    @name = "Water";
    @price = 30;
    @attack = 2;
    @range = 4;
    @speed = 3;

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/droplet.svg";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

window.Water = Water;