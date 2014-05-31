// Generated by CoffeeScript 1.7.1
(function() {
  var Water;

  Water = (function() {
    function Water() {
      this.name = "Water";
      this.price = 30;
      this.attack = 2;
      this.range = 4;
      this.speed = 3;
    }

    Water.prototype.draw = function(ctx, x, y) {
      var image;
      this.ctx = ctx;
      this.x = x;
      this.y = y;
      image = new Image();
      image.src = "img/droplet.svg";
      return this.ctx.drawImage(image, this.x, this.y, 30, 30);
    };

    return Water;

  })();

  window.Water = Water;

}).call(this);

//# sourceMappingURL=water.map
