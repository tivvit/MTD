define ['js/bower_components/easystar.js/bin/easystar-0.1.7.min.js'], (easystar) ->
  class Enemy
    constructor: (@x, @y, @blockSize, @gridSize, @wave, @owner)->
      @name = "Enemy";
      @lives = 10 + (@wave * .5);
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

      pos["x"] = x;
      pos["y"] = y;
      return pos;

    findPath: (grid, host, opponent)->
      easystar = new EasyStar.js()
      easystar.setGrid(grid);
      easystar.setAcceptableTiles([0]);
      pos = @position();
      if !opponent.isOpponent
        ox = opponent.homePosition.x
      else
        ox = (opponent.homePosition.x*2)+1
      easystar.findPath pos.x, pos.y, ox, opponent.homePosition.y, (path) =>
        if (path == null)
          console.log("Path was not found.");
        else
          @path = path;
      easystar.calculate();