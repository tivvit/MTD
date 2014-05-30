requirejs.config({
  baseUrl: 'js'
});

requirejs(['game', 'player'],
(game, player) ->
  new Player;
  g = new Game;
  g.clear();
  #alert "all loaded";
);