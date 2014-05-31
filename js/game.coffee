#alert "hi cofeee";

class Game
  size = {x : 1200, y: 600};
  gridSize = 20;
  blockSize = 30;

  constructor: ->
    @ctx = document.querySelector('#game').getContext('2d');
    @hostPlayer = new Player(blockSize, gridSize);
    @opponent = new Player(blockSize, gridSize, true);
    @draggedOffset = {};
    @wave = 0;
    @nextWave = 30;

    @canvas = document.querySelector('#game');

    @canvas.ondragover = (e) =>
      e.preventDefault();
#      console.log "oo";

    @canvas.ondragenter = (e) =>
      @showBlocked();

    @canvas.ondragleave = (e) =>
      e.preventDefault();
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

      if(x < gridSize*blockSize)
        xx = Math.round(x/blockSize)
        yy =  Math.round(y/blockSize)
#        console.log xx, yy;
        @hostPlayer.addTower(type, xx, yy);
#        @opponent.addTower(type, xx, yy);

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

    setInterval @waveTick, 1000;
    #alert "hi game"

  waveTick: =>
    @nextWave -= 1;
    document.querySelector("#next").innerText = @nextWave;

    if @nextWave == 0
      @nextWave = 10;
      @wave++;
      document.querySelector("#wave").innerText = @wave;

  drawGrid: ->
    @ctx.strokeStyle = "rgba(200,200,200, .2)";
    @ctx.lineWidth = 1;
    @ctx.str
    for y in [0..size.x-blockSize] by blockSize
      for x in [0..size.x-blockSize] by blockSize
        @ctx.strokeRect(x, y, blockSize, blockSize);

  drawSeparator: ->
    @ctx.fillStyle = "black";
    @ctx.fillRect(size.x/2, 0, 1, size.y);

  clear: ->
    @ctx.fillStyle = "rgb(230, 230, 230)";
    @ctx.fillRect(0, 0, size.x, size.y);
    this.drawGrid();
    this.drawSeparator();
    @hostPlayer.draw(@ctx);
    @opponent.draw(@ctx);

    document.querySelector("#lives").innerText = @hostPlayer.lives;
    document.querySelector("#coins").innerText = @hostPlayer.money;

    document.querySelector("#opponentLives").innerText = @opponent.lives;

    document.querySelector("#wave").innerText = @wave;
    document.querySelector("#next").innerText = @nextWave;

  showBlocked: ->
    @ctx.fillStyle = "rgba(250, 0, 0, .1)";
    @ctx.fillRect(gridSize*blockSize, 0, size.x, size.y);


  window.Game = Game;