#alert "hi cofeee";

define ['player'], (Player) ->
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
      @nextWave = 1;
      @waveTime = 10;
      @blocked = false;
      @end = false;

      @canvas = document.querySelector('#game');

      @canvas.ondragover = (e) =>
        e.preventDefault();
  #      console.log "oo";

      @canvas.ondragenter = (e) =>
        @blocked = true;

      @canvas.ondragleave = (e) =>
        e.preventDefault();
        @blocked = false;
        @clear();
      #      console.log "oo";

      @canvas.ondrop = (e) =>
        e.preventDefault();
  #      console.log "haha";
        type = e.dataTransfer.getData("Name");
  #      var dx = pos[0] - img.offsetLeft;
  #    var dy = pos[1] - img.offsetTop;
  #      console.log e.pageX - @draggedOffset.x, e.pageY - @draggedOffset.y;
  #      console.log @canvas.offsetLeft;
        x = e.pageX - @canvas.offsetLeft;# + @draggedOffset.x;
        y = e.pageY - @canvas.offsetTop;# + @draggedOffset.y;

  #      console.log x, y;

        if(x < @gridSize*@blockSize)
          xx = Math.round(x/@blockSize)
          yy =  Math.round(y/@blockSize)
  #        console.log xx, yy;
          if !Object.keys(@hostPlayer.grid[xx][yy]).length
            @hostPlayer.addTower(type, xx, yy);
  #        @opponent.addTower(type, xx, yy);

        @blocked = false;
        @clear();
  #      console.log data;

      for tower in document.querySelectorAll('.tower')
        tower.ondragstart = (e) =>
          e.dataTransfer.setData("Name",e.target.dataset.name);
  #        console.log e.target.dataset;
  #        console.log "draged";
        tower.onmousedown = (e)=>
  #        console.log e.pageX, e.target.id, e.srcElement.offsetLeft, e.srcElement.clientX, e.srcElement.parentElement()..clientX
          @draggedOffset = {x: e.layerX , y: e.layerY}; #e.pageX - e.target.offsetLeft
  #        console.log(@draggedOffset);

      @waveLoop = setInterval @waveTick, 1000;
      @shootLoop = setInterval @shoot, 1000;

      window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
      window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

  #    @step();

  #  step: =>
  #
  ##    @clear();
  ##    ctx.clearRect(0, 0, @canvas.width, @canvas.height);
  #
  #    requestAnimationFrame @step;
  #    console.log @hostPlayer.soldiers.length;
  #
  #    for enemy in @hostPlayer.soldiers
  ##      @ctx.clearRect(enemy.x, enemy.y, 30, 30);
  #      enemy.draw @ctx;
  #      enemy.x++;



      #alert "hi game"

    shoot: =>
      for x in [0...@gridSize]
        for y in [0...@gridSize]
          if Object.keys(@hostPlayer.grid[x][y]).length
            if(@hostPlayer.grid[x][y].name != "Home")
              @hostPlayer.grid[x][y].shoot(@hostPlayer.soldiers, @hostPlayer);
#            @opponent.grid[x][y].shoot(@hostPlayer.soldiers, @opponent);

      if @hostPlayer.lives <= 0
        alert "You Lose";
      if @opponent.lives <= 0
        alert "You Won";
      if @hostPlayer.lives <= 0 || @opponent.lives <= 0
        clearInterval @waveLoop;
        clearInterval @shootLoop;
        @end = true;

    waveTick: =>
      @nextWave -= 1;
      document.querySelector("#next").innerText = @nextWave;

      if @nextWave == 0
        @nextWave = @waveTime;
        @wave++;
        document.querySelector("#wave").innerText = @wave;
        @hostPlayer.sendArmy(@wave, Math.round(@waveTime/2));
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

      document.querySelector("#lives").innerText = @hostPlayer.lives;
      document.querySelector("#coins").innerText = @hostPlayer.money;

      document.querySelector("#opponentLives").innerText = @opponent.lives;

      document.querySelector("#wave").innerText = @wave;
      document.querySelector("#next").innerText = @nextWave;

      if @blocked
        @showBlocked();

      for enemy in @hostPlayer.soldiers
  #      @ctx.clearRect(enemy.x, enemy.y, 30, 30);
        enemy.draw @ctx;
  #      enemy.x++;

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

#return Game;
#  window.Game = Game;