// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['towers/tower', 'towers/config'], function(Tower, config) {
    var Fire;
    return Fire = (function(_super) {
      __extends(Fire, _super);

      function Fire(x, y) {
        this.x = x;
        this.y = y;
        this.name = config.fire.name;
        this.img = config.fire.img;
        this.price = config.fire.price;
        this.attack = config.fire.attack;
        this.range = config.fire.range;
        this.speed = config.fire.speed;
        this.lastShot = 0;
        this.shots = [];
      }

      return Fire;

    })(Tower);
  });

}).call(this);

//# sourceMappingURL=fire.map
