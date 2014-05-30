class Home
  constructor: ->
    @name = "Home";

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/house.png";
    image.onload = =>
      @ctx.drawImage(image,@x, @y);

  window.Home = Home;