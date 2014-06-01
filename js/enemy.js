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
        this.lives = 500 + (this.wave * .1);
        this.speed = .08 + (this.wave * .001);
        this.lastAnimated;
        this.path = [];
        this.path[0] = {
          x: 0,
          y: 9
        };
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
            }
            if (actual.x - this.path[0].x < 0) {
              this.x += this.speed * dt;
            }
            if (actual.y - this.path[0].y > 0) {
              this.y -= this.speed * dt;
            }
            if (actual.y - this.path[0].y < 0) {
              this.y += this.speed * dt;
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
        x = Math.round(this.x / this.blockSize);
        y = Math.round(this.y / this.blockSize);
        pos["x"] = x;
        pos["y"] = y;
        return pos;
      };

      Enemy.prototype.findPath = function(grid, host, opponent) {
        var pos;
        easystar = new EasyStar.js();
        grid[3][9] = 1;
        grid[3][8] = 1;
        grid[3][10] = 1;
        easystar.setGrid(grid);
        easystar.setAcceptableTiles([0]);
        pos = this.position();
        easystar.findPath(pos.x, pos.y, opponent.homePosition.x + this.gridSize, opponent.homePosition.y, (function(_this) {
          return function(path) {
            var x, _i, _len, _results;
            if (path === null) {
              return console.log("Path was not found.");
            } else {
              _this.path = path;
              _results = [];
              for (_i = 0, _len = path.length; _i < _len; _i++) {
                x = path[_i];
                if (x.y !== 9) {
                  _results.push(console.log(x));
                } else {
                  _results.push(void 0);
                }
              }
              return _results;
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
