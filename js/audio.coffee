define ->
  createAudio: ->
    a = new Audio();
    a.controls = true;
    a.canPlayType("audio/mpeg");
    a.src = "music/mario.mp3";
    document.querySelector("#media").appendChild a;
    a.play();