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
          if Object.keys(@grid[x][y]).length
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
      if @isOpponent
        @shift = @gridSize*@blockSize;

      for x in [0...@gridSize]
        for y in [0...@gridSize]
          if Object.keys(@grid[x][y]).length
            @grid[x][y].draw(@ctx,@shift+x*@blockSize,y*@blockSize);