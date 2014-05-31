// Generated by CoffeeScript 1.7.1
(function() {
  define([], function() {
    var Tower;
    return Tower = (function() {
      function Tower() {}

      Tower.prototype.draw = function(ctx, xx, yy) {
        var image;
        this.ctx = ctx;
        image = new Image();
        image.src = this.img;
        return this.ctx.drawImage(image, xx, yy, 30, 30);
      };

      Tower.prototype.shoot = function(enemies) {
        var enemy, key, now, pos, _ref, _results;
        this.enemies = enemies;
        now = new Date().getTime();
        if (now > this.lastShot + this.speed) {
          _ref = this.enemies;
          _results = [];
          for (key in _ref) {
            enemy = _ref[key];
            pos = enemy.position();
            if (pos.x >= this.x - this.range && pos.x <= this.x + this.range && pos.y >= this.y - this.range && pos.y <= this.y + this.range) {
              this.lastShot = now;
              enemy.lives -= this.attack;
              if (enemy.lives <= 0) {
                this.enemies.splice(key, 1);
              }
              break;
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        }
      };

      return Tower;

    })();
  });

}).call(this);

//# sourceMappingURL=tower.map
