#alert "hi cofeee";

define ['player', 'towers/config', 'js/bower_components/easystar.js/bin/easystar-0.1.7.min.js'], (Player, config, easystar) ->
  class Game
    size = {x : 1200, y: 600};

    constructor: ->
      @gridSize = 20;
      @blockSize = 30;
      @ctx = document.querySelector('#game').getContext('2d');
      @hostPlayer = new Player(@blockSize, @gridSize);
      @opponent = new Player(@blockSize, @gridSize, true);
      @draggedOffset = {};
      @wave = 0;
      @nextWave = 30;
      @waveTime = 10;
      @blocked = false;
      @end = false;

      @canvas = document.querySelector('#game');

      @canvas.ondragover = (e) =>
        e.preventDefault();

      @canvas.ondragenter = (e) =>
        @blocked = true;

      @canvas.ondragleave = (e) =>
        e.preventDefault();
        @blocked = false;
        @clear();

      @canvas.ondrop = (e) =>
        e.preventDefault();
        type = e.dataTransfer.getData("Name");
  #      var dx = pos[0] - img.offsetLeft;
  #    var dy = pos[1] - img.offsetTop;
  #      console.log e.pageX - @draggedOffset.x, e.pageY - @draggedOffset.y;
  #      console.log @canvas.offsetLeft;
        x = e.pageX - @canvas.offsetLeft;# + @draggedOffset.x;
        y = e.pageY - @canvas.offsetTop;# + @draggedOffset.y;

        if(x < @gridSize*@blockSize)
          xx = Math.round(x/@blockSize)
          yy =  Math.round(y/@blockSize)

          if(type == "delete")
            @hostPlayer.grid[xx][yy] = {};
          else
            if !Object.keys(@hostPlayer.grid[xx][yy]).length
              easystar = new EasyStar.js()
              mat = @createGameMatrix();
              mat[yy][xx] = 1;
              easystar.setGrid(mat);

              easystar.setAcceptableTiles([0]);
              easystar.findPath @hostPlayer.homePosition.x, @hostPlayer.homePosition.y, (@opponent.homePosition.x*2)+1, @opponent.homePosition.y, (path) =>
                if (path == null)
                  oNewP = document.createElement("p");
                  oText = document.createTextNode("Cannot block path!");
                  oNewP.appendChild(oText);
                  document.querySelector("#messages").appendChild(oNewP);

                  clearTimeout window.clearMessages;
                  window.clearMessages = setTimeout(@clearMessages, 5000);
                else
                  @hostPlayer.addTower(type, xx, yy);
              easystar.calculate();

        @blocked = false;
        @clear();

      for tower in document.querySelectorAll('.tower')
        tower.ondragstart = (e) =>
          e.dataTransfer.setData("Name",e.target.dataset.name);
  #        console.log e.target.dataset;
  #        console.log "draged";
        tower.onmousedown = (e)=>
  #        console.log e.pageX, e.target.id, e.srcElement.offsetLeft, e.srcElement.clientX, e.srcElement.parentElement()..clientX
          @draggedOffset = {x: e.layerX , y: e.layerY}; #e.pageX - e.target.offsetLeft
  #        console.log(@draggedOffset);

      for key, type of config
        parent = document.querySelector("#"+type.name);
        parent.querySelector("img").src = type.img;
        parent.querySelector(".name").textContent = type.name;
        parent.querySelector(".attack").textContent = type.attack;
        parent.querySelector(".speed").textContent = type.speed;
        parent.querySelector(".range").textContent = type.range;
        parent.querySelector(".price").textContent = type.price;

      @waveLoop = setInterval @waveTick, 1000;
      @shootLoop = setInterval @shoot, 100;
      @findPathLoop = setInterval @findPath, 500;

      window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
      window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

    clearMessages: ->
      document.querySelector("#messages").textContent = "";

    findPath: =>
      mat = @createGameMatrix();

      for enemy in @hostPlayer.soldiers
        enemy.findPath(mat, @hostPlayer, @opponent);
      for enemy in @opponent.soldiers
        enemy.findPath(mat, @opponent, @hostPlayer);

    createGameMatrix: =>
      mat = @hostPlayer.generateMatrix();
      mat[@hostPlayer.homePosition.y][@hostPlayer.homePosition.x] = 0;
#      console.log mat;
      mat1 = @opponent.generateMatrix();
      mat1[@opponent.homePosition.y][@opponent.homePosition.x] = 0;

      for x, v of mat1
        for y, val of mat1[x]
          ypos = parseInt(y)+@gridSize;
          mat[x][ypos] = val;

      return mat;

#
    shoot: =>
      for x in [0...@gridSize]
        for y in [0...@gridSize]
          if Object.keys(@hostPlayer.grid[x][y]).length
            @hostPlayer.grid[x][y].shoot(@opponent.soldiers, @hostPlayer);
          if Object.keys(@opponent.grid[x][y]).length
            @opponent.grid[x][y].shoot(@hostPlayer.soldiers, @opponent);

      if @hostPlayer.lives <= 0 || @opponent.lives <= 0
        clearInterval @waveLoop;
        clearInterval @shootLoop;
        clearInterval @findPathLoop
        @end = true;

      if @hostPlayer.lives <= 0
        oNewP = document.createElement("p");
        oText = document.createTextNode("You Lose!");
        oNewP.appendChild(oText);
        document.querySelector("#messages").appendChild(oNewP);
      if @opponent.lives <= 0
        oNewP = document.createElement("p");
        oText = document.createTextNode("You won!");
        oNewP.appendChild(oText);
        document.querySelector("#messages").appendChild(oNewP);

    waveTick: =>
      @nextWave -= 1;
      document.querySelector("#next").textContent = @nextWave;

      if @nextWave == 0
        @nextWave = @waveTime;
        @wave++;
        document.querySelector("#wave").textContent = @wave;
#        @hostPlayer.sendArmy(@wave, Math.round(@waveTime/2));
        @opponent.sendArmy(@wave, Math.round(@waveTime/2));

    drawGrid: ->
      @ctx.strokeStyle = "rgba(200,200,200, .2)";
      @ctx.lineWidth = 1;
      @ctx.str
      for y in [0..size.x-@blockSize] by @blockSize
        for x in [0..size.x-@blockSize] by @blockSize
          @ctx.strokeRect(x, y, @blockSize, @blockSize);

    drawSeparator: ->
      @ctx.fillStyle = "black";
      @ctx.fillRect(size.x/2, 0, 1, size.y);

    clear: =>
      @ctx.clearRect(0, 0, @canvas.width, @canvas.height);
  #    console.log "clearing";
      @ctx.fillStyle = "rgb(230, 230, 230)";
      @ctx.fillRect(0, 0, size.x, size.y);
      @drawGrid();
      @drawSeparator();
      @hostPlayer.draw(@ctx);
      @opponent.draw(@ctx);

      document.querySelector("#lives").textContent = @hostPlayer.lives;
      document.querySelector("#coins").textContent = @hostPlayer.money;

      document.querySelector("#opponentLives").textContent = @opponent.lives;

      document.querySelector("#wave").textContent = @wave;
      document.querySelector("#next").textContent = @nextWave;

      if @blocked
        @showBlocked();

      for enemy in @hostPlayer.soldiers
        enemy.draw @ctx;

      for enemy in @opponent.soldiers
        enemy.draw @ctx;

      if !@end
        requestAnimationFrame @clear;

    showBlocked: ->
      @ctx.fillStyle = "rgba(250, 0, 0, .1)";
      @ctx.fillRect(@gridSize*@blockSize, 0, size.x, size.y);

      for x in [0...@gridSize]
        for y in [0...@gridSize]
          if Object.keys(@hostPlayer.grid[x][y]).length
            @ctx.fillRect(x*@blockSize, y*@blockSize, @blockSize, @blockSize);

    preload: ->
      imageList = [
        "img/alien.png",
        "img/droplet.svg",
        "img/fire.svg",
        "img/house.png",
        "img/leaf.svg",
        "img/twister.svg"
      ];
      for img in imageList
        imageObject = new Image();
        imageObject.src = img;
