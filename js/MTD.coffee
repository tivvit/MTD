requirejs.config({
  baseUrl: 'js'
});

define(['game', 'audio'],
(Game, audio) ->
  audio.createAudio();
  new Game().clear();
);