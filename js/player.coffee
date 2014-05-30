class Player
  constructor: (@blockSize, @gridSize, @isOpponent) ->
    @shift = 0;
    @lives = 10;
    @isOpponent ?= false;
    @homePosition =  {x: 0, y: 9};
    @grid = {};
    @money = 1000;

#    grid initialization
    for x in [0...@gridSize]
      inner = {};
      for y in [0...@gridSize]
        inner[y] = {};
      @grid[x] = inner;

#    check for emptyness
    if Object.keys(@grid).length
      @grid[@homePosition.x][@homePosition.y] = new Home;

  addTower: (@type, @x, @y) ->
    switch @type
      when "Fire" then @grid[x][y] = new Fire;
      when "Water" then @grid[x][y] = new Water;
      when "Nature" then @grid[x][y] = new Nature;
      when "Wind" then @grid[x][y] = new Wind;


  draw: (@ctx) ->
#    console.log @grid;
#    @copy = @clone(@grid);
    @copy = @grid;

    if @isOpponent
      @shift = @gridSize*@blockSize;

#      revert matrix
      for y in [0...@gridSize]
        for x in [0...@gridSize]
          half = @gridSize/2;
          xx = 0;
          if x > half
            xx = Math.floor(2 / (x - half));
            @copy[xx][y] = @grid[x][y];
          else if x < half
            xx = (half - x) * 2;
            @copy[xx-1][y] = @grid[x][y];

    for x in [0...@gridSize]
      for y in [0...@gridSize]
        if Object.keys(@copy[x][y]).length
          @copy[x][y].draw(@ctx,@shift+x*@blockSize,y*@blockSize);

  clone: (obj) ->
    if not obj? or typeof obj isnt 'object'
      return obj

    newInstance = new obj.constructor()

    for key of obj
      newInstance[key] = @clone obj[key]

    return newInstance

  window.Player = Player;