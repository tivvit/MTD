define ['home', 'enemy', 'towers/fire', 'towers/nature', 'towers/water', 'towers/wind'], (Home, Enemy, Fire, Nature, Water, Wind) ->
  class Player
    constructor: (@blockSize, @gridSize, @isOpponent) ->
      @shift = 0;
      @lives = 10;
      @isOpponent ?= false;
      @homePosition =  {x: 0, y: 9};
      @grid = {};
      @money = 500;
      @soldiers = [];

  #    grid initialization
      for x in [0...@gridSize]
        inner = {};
        for y in [0...@gridSize]
          inner[y] = {};
        @grid[x] = inner;

  #    check for emptyness
      if Object.keys(@grid).length
        if !@isOpponent
          @grid[@homePosition.x][@homePosition.y] = new Home(@homePosition.x, @homePosition.y);
        else
          pos = @findMirrored(@homePosition.x, @homePosition.y)
          @homePosition.x = pos.x;
          @homePosition.y = pos.y;
          @grid[pos.x][pos.y] = new Home(pos.x, pos.y);

    findMirrored: (x, y) ->
      half = @gridSize/2;
#      xx = 0;
#      if x > half
#        xx = Math.floor(2 / (x - half));
#        pos = {};
#        pos["x"] = xx;
#        pos["y"] = y;
#        return pos;
#      else if x < half
#        xx = (half - x) * 2;
      xx = @gridSize - 1 - x;
      pos = {};
      pos["x"] = xx;
      pos["y"] = y;
      return pos;

    addTower: (@type, @x, @y) ->
      switch @type
        when "Fire" then @towerfactory(new Fire(x, y), x, y);
        when "Water" then @towerfactory(new Water(x, y), x, y);
        when "Nature" then @towerfactory(new Nature(x, y), x, y);
        when "Wind" then @towerfactory(new Wind(x, y), x, y);

    generateMatrix: ->
      mat = [0...@gridSize];
      for x in mat
        mat[x] = [0...@gridSize];
      for x in [0...@gridSize]
        for y in [0...@gridSize]
          if Object.keys(@copy[x][y]).length
            mat[y][x] = 1;
          else
            mat[y][x] = 0;

      return mat;

    towerfactory: (tower, x, y) ->
      if(@money >= tower.price)
        @money -= tower.price;
        @grid[x][y] = tower;
      else
        oNewP = document.createElement("p");
        oText = document.createTextNode("Not enough money!");
        oNewP.appendChild(oText);
        document.querySelector("#messages").appendChild(oNewP);

        clearTimeout window.clearMessages;
        window.clearMessages = setTimeout (-> document.querySelector("#messages").innerText = ""), 5000;

    sendArmy: (@wave, @time) ->
      @time *= 1000;
      count = 5 + Math.round(@wave/5);
      sent = 0;
      diff = @time/count;
      while count > 0
        setTimeout(@addSoldier, sent);
        sent += diff;
        count--;

    addSoldier: =>
      if !@isOpponent
        @soldiers.push(new Enemy(@blockSize*@homePosition.x, @blockSize*@homePosition.y, @blockSize, @gridSize, @wave, @));
      else
        @soldiers.push(new Enemy(@gridSize*@blockSize+@blockSize*@homePosition.x, @blockSize*@homePosition.y, @blockSize, @gridSize, @wave, @));

    draw: (@ctx) ->
  #    console.log @grid;
#      @copy = @clone(@grid);
      @copy = @grid;

      if @isOpponent
        @shift = @gridSize*@blockSize;

  #      revert matrix
#        for y in [0...@gridSize]
#          for x in [0...@gridSize]
#            half = @gridSize/2;
#            xx = 0;
#            if x > half
#              xx = Math.floor(2 / (x - half));
#              @copy[xx][y] = @grid[x][y];
#            else if x < half
#              xx = (half - x) * 2;
#              @copy[xx-1][y] = @grid[x][y];

      for x in [0...@gridSize]
        for y in [0...@gridSize]
          if Object.keys(@copy[x][y]).length
            @copy[x][y].draw(@ctx,@shift+x*@blockSize,y*@blockSize);

#    clone: (obj) ->
#      if not obj? or typeof obj isnt 'object'
#        return obj
#
#      console.log obj;
#      newInstance = new obj.constructor(obj.x, obj.y);
#
#      for key of obj
#        newInstance[key] = @clone obj[key]
#
#      return newInstance

#  return Player();
#window.Player = Player;