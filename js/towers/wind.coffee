class Wind
  constructor: ->
    @name = "Wind";

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/twister.svg";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

window.Wind = Wind;