// Generated by CoffeeScript 1.7.1
(function() {
  define(['js/bower_components/easystar.js/bin/easystar-0.1.7.min.js'], function(easystar) {
    var Enemy;
    return Enemy = (function() {
      function Enemy(x, y, blockSize, gridSize, wave, owner) {
        this.x = x;
        this.y = y;
        this.blockSize = blockSize;
        this.gridSize = gridSize;
        this.wave = wave;
        this.owner = owner;
        this.name = "Enemy";
        this.lives = 10 + (this.wave * .1);
        this.speed = .08 + (this.wave * .001);
        this.lastAnimated;
        this.path = [];
        this.path[0] = {
          x: 0,
          y: 9
        };
        this.xshift = 0;
        this.yshift = 0;
      }

      Enemy.prototype.draw = function(ctx) {
        var actual, dt, image, now;
        this.ctx = ctx;
        if (this.path.length > 0) {
          now = new Date().getTime();
          dt = now - (this.lastAnimated || now);
          this.lastAnimated = now;
          actual = this.position();
          if (!(actual.x === 0 && actual.y === 9 && this.path.length === 1) && actual.x === this.path[0].x && actual.y === this.path[0].y) {
            this.path.splice(0, 1);
          }
          if (this.path.length > 0) {
            if (actual.x - this.path[0].x > 0) {
              this.x -= this.speed * dt;
              this.xshift = 15;
            }
            if (actual.x - this.path[0].x < 0) {
              this.x += this.speed * dt;
              this.xshift = -15;
            }
            if (actual.y - this.path[0].y > 0) {
              this.y -= this.speed * dt;
              this.yshift = 15;
            }
            if (actual.y - this.path[0].y < 0) {
              this.y += this.speed * dt;
              this.yshift = -15;
            }
          }
          image = new Image();
          image.src = "img/alien.png";
          return this.ctx.drawImage(image, this.x, this.y, 30, 30);
        }
      };

      Enemy.prototype.position = function() {
        var pos, x, y;
        pos = {};
        x = Math.round((this.x + this.xshift) / this.blockSize);
        y = Math.round((this.y + this.yshift) / this.blockSize);
        pos["x"] = x;
        pos["y"] = y;
        return pos;
      };

      Enemy.prototype.findPath = function(grid, host, opponent) {
        var ox, pos;
        easystar = new EasyStar.js();
        easystar.setGrid(grid);
        easystar.setAcceptableTiles([0]);
        pos = this.position();
        if (!opponent.isOpponent) {
          ox = opponent.homePosition.x;
        } else {
          ox = (opponent.homePosition.x * 2) + 1;
        }
        easystar.findPath(pos.x, pos.y, ox, opponent.homePosition.y, (function(_this) {
          return function(path) {
            if (path === null) {
              return console.log("Path was not found.");
            } else {
              return _this.path = path;
            }
          };
        })(this));
        return easystar.calculate();
      };

      return Enemy;

    })();
  });

}).call(this);

//# sourceMappingURL=enemy.map
