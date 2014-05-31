define [], () ->
  class Tower
    draw: (@ctx, xx, yy) ->
      image = new Image();
      image.src = @img;
      #    image.onload = =>
      @ctx.drawImage(image,xx, yy, 30, 30);

    shoot: (@enemies) ->
      now = new Date().getTime();
      if now > @lastShot+@speed
        for key,enemy of @enemies
          pos = enemy.position();
          if pos.x >= @x-@range && pos.x <= @x+@range && pos.y >= @y-@range && pos.y <= @y+@range
            @lastShot = now;
            enemy.lives -= @attack;
            if enemy.lives <= 0
              @enemies.splice(key, 1);
            break;

#  return Tower;

#window.Tower = Tower;