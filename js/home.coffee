define [], () ->
  class Home
    constructor: ->
      @name = "Home";

    draw: (@ctx, @x, @y) ->
      image = new Image();
      image.src = "img/house.png";
  #    @ctx.fillRect(@x, @y, 30, 30);
  #    image.onload = =>
      @ctx.drawImage(image,@x, @y, 30, 30);

#  window.Home = Home;