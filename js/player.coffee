class Player
  constructor: (@blockSize, @gridSize, @isOpponent) ->
    @shift = 0;
    @lives = 10;
    @isOpponent ?= false;
    @homePosition =  {x: 0, y: 9};
    @grid = {}

#    grid initialization
    for x in [0...@gridSize]
      inner = {};
      for y in [0...@gridSize]
        inner[y] = {};
      @grid[x] = inner;

#    check for emptyness
    if Object.keys(@grid).length
      @grid[@homePosition.x][@homePosition.y] = new Home;

  draw: (@ctx) ->
    if @isOpponent
      @shift = @gridSize*@blockSize;
#      @homePosition.x = @gridSize-1; #otočení matice

    for x in [0...@gridSize]
      for y in [0...@gridSize]
        if Object.keys(@grid[x][y]).length
          @grid[x][y].draw(@ctx,@shift+x*@blockSize,y*@blockSize)

#    image = new Image();
#    image.src = "img/house.png";
#    image.onload = =>
#      @ctx.drawImage(image,@shift+(@homePosition.x*@blockSize),@homePosition.y*@blockSize);

  window.Player = Player;