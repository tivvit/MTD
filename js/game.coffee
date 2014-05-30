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
      data = e.dataTransfer.getData("Name");
      @clear();
#      console.log data;

    for tower in document.querySelectorAll('.tower')
      tower.ondragstart = (e) =>
        e.dataTransfer.setData("Name",e.target.dataset.name);
#        console.log e.target.dataset;
#        console.log "draged";
      tower.onmousedown = (e)=>
        @draggedOffset = {x: e.pageX, y:e.pageY};
#        console.log(@draggedOffset);
    #alert "hi game"

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

  showBlocked: ->
    @ctx.fillStyle = "rgba(250, 0, 0, .1)";
    @ctx.fillRect(gridSize*blockSize, 0, size.x, size.y);


  window.Game = Game;