define ['js/bower_components/easystar.js/bin/easystar-0.1.7.min.js'], (easystar) ->
  class Enemy
    constructor: (@x, @y, @blockSize, @gridSize, @wave, @owner)->
      @name = "Enemy";
      @lives = 500 + (@wave * .1);
      @speed = .08 + (@wave * .001);
      @lastAnimated;
      @path = []
      @path[0] = {x: 0, y: 9};
      @xshift = 0;
      @yshift = 0;

    draw: (@ctx) ->
      if @path.length > 0
        now = new Date().getTime();
        dt = now - (@lastAnimated || now);

        @lastAnimated = now;

        actual = @position();
        if !(actual.x == 0 && actual.y == 9 && @path.length == 1) && actual.x == @path[0].x && actual.y == @path[0].y
          @path.splice(0,1);

#        console.log @path;
        if(@path.length > 0)
          if actual.x - @path[0].x > 0
            @x -= @speed * dt;
            @xshift = 15;
          if actual.x - @path[0].x < 0
            @x += @speed * dt;
            @xshift = -15;
          if actual.y - @path[0].y > 0
            @y -= @speed * dt;
            @yshift = 15;
          if actual.y - @path[0].y < 0
            @y += @speed * dt;
            @yshift = -15;

        image = new Image();
        image.src = "img/alien.png";
    #    image.onload = =>
        @ctx.drawImage(image,@x, @y, 30, 30);

    position: ->
      pos = {};
      x = Math.round((@x+@xshift)/@blockSize);
      y = Math.round((@y+@yshift)/@blockSize);
#      if x >= 20
#        x -= 20;
#      if y >= 20
#        y -=20;
      pos["x"] = x;
      pos["y"] = y;
      return pos;

    findPath: (grid, host, opponent)->
#      console.log EasyStar.js()
      easystar = new EasyStar.js()
      easystar.setGrid(grid);
      easystar.setAcceptableTiles([0]);
      pos = @position();
#      console.log grid
#      console.log opponent.homePosition.x, opponent.homePosition.y
      easystar.findPath pos.x, pos.y, (opponent.homePosition.x*2)+1, opponent.homePosition.y, (path) =>
        if (path == null)
          console.log("Path was not found.");
        else
          @path = path;
      easystar.calculate();


#window.Enemy = Enemy;