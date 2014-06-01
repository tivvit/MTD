// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['player', 'towers/config'], function(Player, config) {
    var Game;
    return Game = (function() {
      var size;

      size = {
        x: 1200,
        y: 600
      };

      function Game() {
        this.clear = __bind(this.clear, this);
        this.waveTick = __bind(this.waveTick, this);
        this.shoot = __bind(this.shoot, this);
        var key, parent, tower, type, _i, _len, _ref;
        this.gridSize = 20;
        this.blockSize = 30;
        this.ctx = document.querySelector('#game').getContext('2d');
        this.hostPlayer = new Player(this.blockSize, this.gridSize);
        this.opponent = new Player(this.blockSize, this.gridSize, true);
        this.draggedOffset = {};
        this.wave = 0;
        this.nextWave = 1;
        this.waveTime = 10;
        this.blocked = false;
        this.end = false;
        this.canvas = document.querySelector('#game');
        this.canvas.ondragover = (function(_this) {
          return function(e) {
            return e.preventDefault();
          };
        })(this);
        this.canvas.ondragenter = (function(_this) {
          return function(e) {
            return _this.blocked = true;
          };
        })(this);
        this.canvas.ondragleave = (function(_this) {
          return function(e) {
            e.preventDefault();
            _this.blocked = false;
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
            if (x < _this.gridSize * _this.blockSize) {
              xx = Math.round(x / _this.blockSize);
              yy = Math.round(y / _this.blockSize);
              if (!Object.keys(_this.hostPlayer.grid[xx][yy]).length) {
                _this.hostPlayer.addTower(type, xx, yy);
              }
            }
            _this.blocked = false;
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
        for (key in config) {
          type = config[key];
          parent = document.querySelector("#" + type.name);
          parent.querySelector("img").src = type.img;
          parent.querySelector(".name").innerText = type.name;
          parent.querySelector(".attack").innerText = type.attack;
          parent.querySelector(".speed").innerText = type.speed;
          parent.querySelector(".range").innerText = type.range;
          parent.querySelector(".price").innerText = type.price;
        }
        this.waveLoop = setInterval(this.waveTick, 1000);
        this.shootLoop = setInterval(this.shoot, 100);
        window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
      }

      Game.prototype.shoot = function() {
        var x, y, _i, _j, _ref, _ref1;
        for (x = _i = 0, _ref = this.gridSize; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
          for (y = _j = 0, _ref1 = this.gridSize; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
            if (Object.keys(this.hostPlayer.grid[x][y]).length) {
              if (this.hostPlayer.grid[x][y].name !== "Home") {
                this.hostPlayer.grid[x][y].shoot(this.hostPlayer.soldiers, this.hostPlayer);
              }
            }
            if (Object.keys(this.opponent.grid[x][y]).length) {
              this.opponent.grid[x][y].shoot(this.hostPlayer.soldiers, this.opponent);
            }
          }
        }
        if (this.hostPlayer.lives <= 0 || this.opponent.lives <= 0) {
          clearInterval(this.waveLoop);
          clearInterval(this.shootLoop);
          this.end = true;
        }
        if (this.hostPlayer.lives <= 0) {
          alert("You Lose");
        }
        if (this.opponent.lives <= 0) {
          return alert("You Won");
        }
      };

      Game.prototype.waveTick = function() {
        this.nextWave -= 1;
        document.querySelector("#next").innerText = this.nextWave;
        if (this.nextWave === 0) {
          this.nextWave = this.waveTime;
          this.wave++;
          document.querySelector("#wave").innerText = this.wave;
          this.hostPlayer.sendArmy(this.wave, Math.round(this.waveTime / 2));
          return this.opponent.sendArmy(this.wave, Math.round(this.waveTime / 2));
        }
      };

      Game.prototype.drawGrid = function() {
        var x, y, _i, _ref, _ref1, _results;
        this.ctx.strokeStyle = "rgba(200,200,200, .2)";
        this.ctx.lineWidth = 1;
        this.ctx.str;
        _results = [];
        for (y = _i = 0, _ref = size.x - this.blockSize, _ref1 = this.blockSize; _ref1 > 0 ? _i <= _ref : _i >= _ref; y = _i += _ref1) {
          _results.push((function() {
            var _j, _ref2, _ref3, _results1;
            _results1 = [];
            for (x = _j = 0, _ref2 = size.x - this.blockSize, _ref3 = this.blockSize; _ref3 > 0 ? _j <= _ref2 : _j >= _ref2; x = _j += _ref3) {
              _results1.push(this.ctx.strokeRect(x, y, this.blockSize, this.blockSize));
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
        var enemy, _i, _len, _ref;
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        this.ctx.fillStyle = "rgb(230, 230, 230)";
        this.ctx.fillRect(0, 0, size.x, size.y);
        this.drawGrid();
        this.drawSeparator();
        this.hostPlayer.draw(this.ctx);
        this.opponent.draw(this.ctx);
        document.querySelector("#lives").innerText = this.hostPlayer.lives;
        document.querySelector("#coins").innerText = this.hostPlayer.money;
        document.querySelector("#opponentLives").innerText = this.opponent.lives;
        document.querySelector("#wave").innerText = this.wave;
        document.querySelector("#next").innerText = this.nextWave;
        if (this.blocked) {
          this.showBlocked();
        }
        _ref = this.hostPlayer.soldiers;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          enemy = _ref[_i];
          enemy.draw(this.ctx);
        }
        if (!this.end) {
          return requestAnimationFrame(this.clear);
        }
      };

      Game.prototype.showBlocked = function() {
        var x, y, _i, _ref, _results;
        this.ctx.fillStyle = "rgba(250, 0, 0, .1)";
        this.ctx.fillRect(this.gridSize * this.blockSize, 0, size.x, size.y);
        _results = [];
        for (x = _i = 0, _ref = this.gridSize; 0 <= _ref ? _i < _ref : _i > _ref; x = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (y = _j = 0, _ref1 = this.gridSize; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; y = 0 <= _ref1 ? ++_j : --_j) {
              if (Object.keys(this.hostPlayer.grid[x][y]).length) {
                _results1.push(this.ctx.fillRect(x * this.blockSize, y * this.blockSize, this.blockSize, this.blockSize));
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      Game.prototype.preload = function() {
        var imageList, imageObject, img, _i, _len, _results;
        imageList = ["img/alien.png", "img/droplet.svg", "img/fire.svg", "img/house.png", "img/leaf.svg", "img/twister.svg"];
        _results = [];
        for (_i = 0, _len = imageList.length; _i < _len; _i++) {
          img = imageList[_i];
          imageObject = new Image();
          _results.push(imageObject.src = img);
        }
        return _results;
      };

      return Game;

    })();
  });

}).call(this);

//# sourceMappingURL=game.map
