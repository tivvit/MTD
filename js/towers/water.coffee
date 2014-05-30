class Water
  constructor: ->
    @name = "Water";

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/droplet.svg";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

window.Water = Water;