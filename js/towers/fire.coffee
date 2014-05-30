class Fire
  constructor: ->
    @name = "Fire";

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/fire.svg";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

window.Fire = Fire;