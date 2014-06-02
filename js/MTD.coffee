requirejs.config({
  baseUrl: 'js'
});

define(['game', 'audio'],
(Game, audio) ->
  audio.createAudio();
  new Game().clear();

  window.addEventListener("online", ->  alert "Connection restored");
  window.addEventListener("offline", -> alert "Connection lost");

);