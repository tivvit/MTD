// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['home', 'enemy', 'towers/fire', 'towers/nature', 'towers/water', 'towers/wind'], function(Home, Enemy, Fire, Nature, Water, Wind) {
    var Player;
    return Player = (function() {
      function Player(blockSize, gridSize, isOpponent) {
        var inner, pos, x, y, _i, _j, _ref, _ref1;
        this.blockSize = blockSize;
        this.gridSize = gridSize;
        this.isOpponent = isOpponent;
        this.addSoldier = __bind(this.addSoldier, this);
        this.shift = 0;
        this.lives = 10;
        if (this.isOpponent == null) {
          this.isOpponent = false;
        }
        this.homePosition = {
          x: 0,
          y: 9
        };
        this.grid = {};
        this.money = 500;
        this.soldiers = [];
        for (x = _i = 0, _ref = this.gridSize; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
          inner = {};
          for (y = _j = 0, _ref1 = this.gridSize; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
            inner[y] = {};
          }
          this.grid[x] = inner;
        }
        if (Object.keys(this.grid).length) {
          if (!this.isOpponent) {
            this.grid[this.homePosition.x][this.homePosition.y] = new Home(this.homePosition.x, this.homePosition.y);
          } else {
            pos = this.findMirrored(this.homePosition.x, this.homePosition.y);
            this.homePosition.x = pos.x;
            this.homePosition.y = pos.y;
            this.grid[pos.x][pos.y] = new Home(pos.x, pos.y);
          }
        }
      }

      Player.prototype.findMirrored = function(x, y) {
        var pos, xx;
        xx = this.gridSize - 1 - x;
        pos = {};
        pos["x"] = xx;
        pos["y"] = y;
        return pos;
      };

      Player.prototype.addTower = function(type, x, y) {
        this.type = type;
        this.x = x;
        this.y = y;
        switch (this.type) {
          case "Fire":
            return this.towerfactory(new Fire(x, y), x, y);
          case "Water":
            return this.towerfactory(new Water(x, y), x, y);
          case "Nature":
            return this.towerfactory(new Nature(x, y), x, y);
          case "Wind":
            return this.towerfactory(new Wind(x, y), x, y);
        }
      };

      Player.prototype.generateMatrix = function() {
        var mat, x, y, _i, _j, _k, _l, _len, _m, _ref, _ref1, _ref2, _ref3, _results, _results1;
        mat = (function() {
          _results = [];
          for (var _i = 0, _ref = this.gridSize; 0 <= _ref ? _i < _ref : _i > _ref; 0 <= _ref ? _i++ : _i--){ _results.push(_i); }
          return _results;
        }).apply(this);
        for (_j = 0, _len = mat.length; _j < _len; _j++) {
          x = mat[_j];
          mat[x] = (function() {
            _results1 = [];
            for (var _k = 0, _ref1 = this.gridSize; 0 <= _ref1 ? _k < _ref1 : _k > _ref1; 0 <= _ref1 ? _k++ : _k--){ _results1.push(_k); }
            return _results1;
          }).apply(this);
        }
        for (x = _l = 0, _ref2 = this.gridSize; 0 <= _ref2 ? _l < _ref2 : _l > _ref2; x = 0 <= _ref2 ? ++_l : --_l) {
          for (y = _m = 0, _ref3 = this.gridSize; 0 <= _ref3 ? _m < _ref3 : _m > _ref3; y = 0 <= _ref3 ? ++_m : --_m) {
            if (Object.keys(this.grid[x][y]).length) {
              mat[y][x] = 1;
            } else {
              mat[y][x] = 0;
            }
          }
        }
        return mat;
      };

      Player.prototype.towerfactory = function(tower, x, y) {
        var oNewP, oText;
        if (this.money >= tower.price) {
          this.money -= tower.price;
          return this.grid[x][y] = tower;
        } else {
          oNewP = document.createElement("p");
          oText = document.createTextNode("Not enough money!");
          oNewP.appendChild(oText);
          document.querySelector("#messages").appendChild(oNewP);
          clearTimeout(window.clearMessages);
          return window.clearMessages = setTimeout((function() {
            return document.querySelector("#messages").innerText = "";
          }), 5000);
        }
      };

      Player.prototype.sendArmy = function(wave, time) {
        var count, diff, sent, _results;
        this.wave = wave;
        this.time = time;
        this.time *= 1000;
        count = 5 + Math.round(this.wave / 5);
        sent = 0;
        diff = this.time / count;
        _results = [];
        while (count > 0) {
          setTimeout(this.addSoldier, sent);
          sent += diff;
          _results.push(count--);
        }
        return _results;
      };

      Player.prototype.addSoldier = function() {
        if (!this.isOpponent) {
          return this.soldiers.push(new Enemy(this.blockSize * this.homePosition.x, this.blockSize * this.homePosition.y, this.blockSize, this.gridSize, this.wave, this));
        } else {
          return this.soldiers.push(new Enemy(this.gridSize * this.blockSize + this.blockSize * this.homePosition.x, this.blockSize * this.homePosition.y, this.blockSize, this.gridSize, this.wave, this));
        }
      };

      Player.prototype.draw = function(ctx) {
        var x, y, _i, _ref, _results;
        this.ctx = ctx;
        if (this.isOpponent) {
          this.shift = this.gridSize * this.blockSize;
        }
        _results = [];
        for (x = _i = 0, _ref = this.gridSize; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (y = _j = 0, _ref1 = this.gridSize; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
              if (Object.keys(this.grid[x][y]).length) {
                _results1.push(this.grid[x][y].draw(this.ctx, this.shift + x * this.blockSize, y * this.blockSize));
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      return Player;

    })();
  });

}).call(this);

//# sourceMappingURL=player.map
