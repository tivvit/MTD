class Nature
  constructor: ->
    @name = "Nature";

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/leaf.svg";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

window.Nature = Nature;