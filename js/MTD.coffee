requirejs.config({
  baseUrl: 'js'
});

define(['game'],
(Game) ->
  new Game().clear();
);