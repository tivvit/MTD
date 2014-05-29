requirejs.config({
  baseUrl: 'js'
});

requirejs(['game'],
(game) ->
  g = new Game;
  g.draw();
  #alert "all loaded";
);