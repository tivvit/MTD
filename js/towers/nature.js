// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['towers/tower', 'towers/config'], function(Tower, config) {
    var Nature;
    return Nature = (function(_super) {
      __extends(Nature, _super);

      function Nature(x, y) {
        this.x = x;
        this.y = y;
        this.name = config.nature.name;
        this.img = config.nature.img;
        this.price = config.nature.price;
        this.attack = config.nature.attack;
        this.range = config.nature.range;
        this.speed = config.nature.speed;
        this.lastShot = 0;
        this.shots = [];
      }

      return Nature;

    })(Tower);
  });

}).call(this);

//# sourceMappingURL=nature.map
