define [], () ->
  class Tower
    construcor: ->
      @lastShot;

    draw: (@ctx, xx, yy) ->
      image = new Image();
      image.src = @img;
      #    image.onload = =>
      @ctx.drawImage(image,xx, yy, 30, 30);

    shoot: (@enemies) ->
      for enemy in @enemies
        pos = enemy.position();
        if pos.x >= @x-@range && pos.x <= @x+@range && pos.y >= @y-@range && pos.y <= @y+@range
          console.log enemy;

#  return Tower;

#window.Tower = Tower;