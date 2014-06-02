requirejs.config({
  baseUrl: 'js'
});

define(['game', 'audio'],
(Game, audio) ->
  audio.createAudio();

  if window.location.hash == ""
    window.location.hash = "#menu"

  window.addEventListener "hashchange", =>
    if window.location.hash == "#single"

      new Game();

  window.addEventListener("online", ->  alert "Connection restored");
  window.addEventListener("offline", -> alert "Connection lost");

);