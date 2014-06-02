requirejs.config({
  baseUrl: 'js'
});

define(['game', 'audio', 'logo'],
(Game, audio, logo) ->
  audio.createAudio();

  if window.location.hash == ""
    window.location.hash = "#menu"

  logo.drawLogo();
  
  @name = "You";

  document.querySelector("form").addEventListener "submit", (e) ->
    e.preventDefault();

  document.querySelector("input[name]").addEventListener "change", (e) =>
    @name = e.srcElement.value;

  window.addEventListener "hashchange", =>
    if window.location.hash == "#single"
      new Game(@name);

  window.addEventListener("online", ->  alert "Connection restored");
  window.addEventListener("offline", -> alert "Connection lost");

);