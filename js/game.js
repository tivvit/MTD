// Generated by CoffeeScript 1.7.1
(function() {
  var Game;

  Game = (function() {
    var blockSize, gridSize, size;

    size = {
      x: 1200,
      y: 600
    };

    gridSize = 20;

    blockSize = 30;

    function Game() {
      var tower, _i, _len, _ref;
      this.ctx = document.querySelector('#game').getContext('2d');
      this.hostPlayer = new Player(blockSize, gridSize);
      this.opponent = new Player(blockSize, gridSize, true);
      this.draggedOffset = {};
      this.canvas = document.querySelector('#game');
      this.canvas.ondragover = (function(_this) {
        return function(e) {
          return e.preventDefault();
        };
      })(this);
      this.canvas.ondragenter = (function(_this) {
        return function(e) {
          return _this.showBlocked();
        };
      })(this);
      this.canvas.ondragleave = (function(_this) {
        return function(e) {
          e.preventDefault();
          return _this.clear();
        };
      })(this);
      this.canvas.ondrop = (function(_this) {
        return function(e) {
          var type, x, xx, y, yy;
          e.preventDefault();
          type = e.dataTransfer.getData("Name");
          x = e.pageX - _this.canvas.offsetLeft;
          y = e.pageY - _this.canvas.offsetTop;
          if (x < gridSize * blockSize) {
            xx = Math.round(x / blockSize);
            yy = Math.round(y / blockSize);
            _this.hostPlayer.addTower(type, xx, yy);
          }
          return _this.clear();
        };
      })(this);
      _ref = document.querySelectorAll('.tower');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        tower = _ref[_i];
        tower.ondragstart = (function(_this) {
          return function(e) {
            return e.dataTransfer.setData("Name", e.target.dataset.name);
          };
        })(this);
        tower.onmousedown = (function(_this) {
          return function(e) {
            return _this.draggedOffset = {
              x: e.layerX,
              y: e.layerY
            };
          };
        })(this);
      }
    }

    Game.prototype.drawGrid = function() {
      var x, y, _i, _ref, _results;
      this.ctx.strokeStyle = "rgba(200,200,200, .2)";
      this.ctx.lineWidth = 1;
      this.ctx.str;
      _results = [];
      for (y = _i = 0, _ref = size.x - blockSize; blockSize > 0 ? _i <= _ref : _i >= _ref; y = _i += blockSize) {
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (x = _j = 0, _ref1 = size.x - blockSize; blockSize > 0 ? _j <= _ref1 : _j >= _ref1; x = _j += blockSize) {
            _results1.push(this.ctx.strokeRect(x, y, blockSize, blockSize));
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    Game.prototype.drawSeparator = function() {
      this.ctx.fillStyle = "black";
      return this.ctx.fillRect(size.x / 2, 0, 1, size.y);
    };

    Game.prototype.clear = function() {
      this.ctx.fillStyle = "rgb(230, 230, 230)";
      this.ctx.fillRect(0, 0, size.x, size.y);
      this.drawGrid();
      this.drawSeparator();
      this.hostPlayer.draw(this.ctx);
      this.opponent.draw(this.ctx);
      document.querySelector("#lives").innerText = this.hostPlayer.lives;
      return document.querySelector("#coins").innerText = this.hostPlayer.money;
    };

    Game.prototype.showBlocked = function() {
      this.ctx.fillStyle = "rgba(250, 0, 0, .1)";
      return this.ctx.fillRect(gridSize * blockSize, 0, size.x, size.y);
    };

    window.Game = Game;

    return Game;

  })();

}).call(this);

//# sourceMappingURL=game.map
