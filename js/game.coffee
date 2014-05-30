#alert "hi cofeee";

class Game
  size = {x : 1200, y: 600};
  grideSize = 20;
  blockSize = 30;

  constructor: ->
    @ctx = document.getElementById('game').getContext('2d');
    @hostPlayer = new Player(blockSize, grideSize);
    @opponent = new Player(blockSize, grideSize, true);
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


  window.Game = Game;