class Player
  constructor: (@blockSize, @gridSize, @isOpponent) ->
    @shift = 0;
    @lives = 10;
    @isOpponent ?= false;
    @homePosition =  {x: 0, y: 9};
    @grid = {}
    x = 0;
    for x in [0...@gridSize]
      inner = {};
      y = 0;
      for y in [0...@gridSize]
        inner[y] = {};
        y++;
      @grid[x] = inner;
      x++

#    check for emptyness
    if Object.keys(@grid).length
      @grid[@homePosition.x][@homePosition.y] = {"name": "home"};
    console.log @grid

  draw: (@ctx) ->
    if(@isOpponent)
      @shift = @gridSize*@blockSize;
      @homePosition.x = @gridSize-1; #otočení matice

    image = new Image();
    image.src = "img/house.png";
    image.onload = =>
      @ctx.drawImage(image,@shift+(@homePosition.x*@blockSize),@homePosition.y*@blockSize);

  isEmpty: (obj)->
    for key in obj
      if(obj.hasOwnProperty(key))
        return false;
    return true;

  window.Player = Player;