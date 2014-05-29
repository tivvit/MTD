#alert "hi cofeee";

class Game
  size = {x : 1200, y: 600};

  constructor: ->
    @ctx = document.getElementById('game').getContext('2d');
    #alert "hi game"

  draw: ->
    @ctx.fillStyle = "rgb(220, 220, 220)";
    @ctx.fillRect(0, 0, size.x, size.y);

  window.Game = Game;