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
            @enemies.splice(key, 1);
            console.log "bang";
            break;

#  return Tower;

#window.Tower = Tower;