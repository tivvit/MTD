// Generated by CoffeeScript 1.7.1
(function() {
  define(['shot'], function(Shot) {
    var Tower;
    return Tower = (function() {
      function Tower() {}

      Tower.prototype.draw = function(ctx, xx, yy) {
        var ekey, image, key, shot, _ref, _results;
        image = new Image();
        image.src = this.img;
        ctx.drawImage(image, xx, yy, 30, 30);
        _ref = this.shots;
        _results = [];
        for (key in _ref) {
          shot = _ref[key];
          shot.draw(ctx);
          if (shot.hit) {
            if (shot.enemy.lives <= 0) {
              ekey = this.enemies.indexOf(shot.enemy);
              if (ekey !== -1) {
                this.enemies.splice(ekey, 1);
                this.owner.money += 4;
              }
            }
            _results.push(this.shots.splice(key, 1));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };

      Tower.prototype.shoot = function(enemies, owner) {
        var enemy, key, now, pos, _ref, _results;
        this.enemies = enemies;
        this.owner = owner;
        now = new Date().getTime();
        if (now > this.lastShot + this.speed) {
          _ref = this.enemies;
          _results = [];
          for (key in _ref) {
            enemy = _ref[key];
            pos = enemy.position();
            if (pos.x >= this.x - this.range && pos.x <= this.x + this.range && pos.y >= this.y - this.range && pos.y <= this.y + this.range) {
              this.lastShot = now;
              this.shots.push(new Shot(this.x, this.y, enemy.x, enemy.y, enemy, this.name));
              enemy.lives -= this.attack;
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
