requirejs.config({
  baseUrl: 'js'
});

requirejs(['game', 'player', 'home', 'towers/fire', 'towers/water', 'towers/nature', 'towers/wind', 'enemy'],
(game, player, home, fire, water, nature, wind) ->
  new Player;
  g = new Game;
  g.clear();
  #alert "all loaded";
);