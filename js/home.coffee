class Home
  constructor: ->
    @name = "Home";

  draw: (@ctx, @x, @y) ->
    image = new Image();
    image.src = "img/house.png";
    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

  window.Home = Home;