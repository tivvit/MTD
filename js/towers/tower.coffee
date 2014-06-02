define ['shot'], (Shot) ->
  class Tower
    draw: (ctx, xx, yy) ->
      image = new Image();
      image.src = @img;
      #    image.onload = =>
      ctx.drawImage(image,xx, yy, 30, 30);

      for key, shot of @shots
        shot.draw(ctx);
        if shot.hit
          if shot.enemy.lives <= 0
            ekey = @enemies.indexOf(shot.enemy)
            if ekey != -1
              @enemies.splice(ekey, 1);
              @owner.money += 4; #todo income to config
          @shots.splice(key, 1);


    shoot: (@enemies, @owner) ->
      now = new Date().getTime();
      if now > @lastShot+@speed
        for key,enemy of @enemies
          pos = enemy.position();
          if pos.x >= @x-@range && pos.x <= @x+@range && pos.y >= @y-@range && pos.y <= @y+@range
            @lastShot = now;
#            console.log Shot;
            @shots.push new Shot(@x, @y, enemy.x, enemy.y, enemy, @name);
            enemy.lives -= @attack;
#            console.log enemy;
            break;
