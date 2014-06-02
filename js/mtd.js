// Generated by CoffeeScript 1.7.1
(function() {
  requirejs.config({
    baseUrl: 'js'
  });

  define(['game', 'audio', 'logo'], function(Game, audio, logo) {
    audio.createAudio();
    if (window.location.hash === "") {
      window.location.hash = "#menu";
    }
    logo.drawLogo();
    this.name = "You";
    document.querySelector("form").addEventListener("submit", function(e) {
      return e.preventDefault();
    });
    document.querySelector("input[name]").addEventListener("change", (function(_this) {
      return function(e) {
        return _this.name = e.srcElement.value;
      };
    })(this));
    window.addEventListener("hashchange", (function(_this) {
      return function() {
        if (window.location.hash === "#single") {
          return new Game(_this.name);
        }
      };
    })(this));
    window.addEventListener("online", function() {
      return alert("Connection restored");
    });
    return window.addEventListener("offline", function() {
      return alert("Connection lost");
    });
  });

}).call(this);

//# sourceMappingURL=MTD.map
