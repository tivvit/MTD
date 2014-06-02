define [], () ->
  class Home
    constructor: (@x, @y)->
      @name = "Home";

    draw: (ctx, xx, yy) ->
      image = new Image();
      image.src = "img/home.svg";
  #    image.onload = =>
      ctx.drawImage(image,xx, yy, 30, 30);

    shoot: (@enemies, @owner) ->
      for key,enemy of @enemies
        pos = enemy.position();

        if @owner.isOpponent && pos.x >= 20
          pos.x -= 20;

        if pos.x == @x && pos.y == @y
            @enemies.splice(key, 1);
            @owner.lives--;
