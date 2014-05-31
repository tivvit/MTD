requirejs.config({
  baseUrl: 'js'
});

define(['game', 'player', 'home', 'towers/fire', 'towers/water', 'towers/nature', 'towers/wind', 'enemy'],
(Game, player, home, fire, water, nature, wind) ->
#  new Player;
#  g = new Game;
  new Game().clear();
  #alert "all loaded";
);