// Generated by CoffeeScript 1.7.1
(function() {
  var Home;

  Home = (function() {
    function Home() {
      this.name = "Home";
    }

    Home.prototype.draw = function(ctx, x, y) {
      var image;
      this.ctx = ctx;
      this.x = x;
      this.y = y;
      image = new Image();
      image.src = "img/house.png";
      return image.onload = (function(_this) {
        return function() {
          return _this.ctx.drawImage(image, _this.x, _this.y, 30, 30);
        };
      })(this);
    };

    window.Home = Home;

    return Home;

  })();

}).call(this);

//# sourceMappingURL=home.map
