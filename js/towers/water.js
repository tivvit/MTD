// Generated by CoffeeScript 1.7.1
(function() {
  var Water;

  Water = (function() {
    function Water() {
      this.name = "Water";
    }

    Water.prototype.draw = function(ctx, x, y) {
      var image;
      this.ctx = ctx;
      this.x = x;
      this.y = y;
      image = new Image();
      image.src = "img/droplet.svg";
      return image.onload = (function(_this) {
        return function() {
          return _this.ctx.drawImage(image, _this.x, _this.y, 30, 30);
        };
      })(this);
    };

    return Water;

  })();

  window.Water = Water;

}).call(this);

//# sourceMappingURL=water.map
