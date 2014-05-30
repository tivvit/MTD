requirejs.config({
  baseUrl: 'js'
});

requirejs(['game', 'player', 'home'],
(game, player, home) ->
  new Player;
  g = new Game;
  g.clear();
  #alert "all loaded";
);