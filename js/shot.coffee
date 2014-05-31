class Shot
  constructor: (@x, @y)->
    @name = "Shot";
    @speed = .01;
    @lastAnimated;

  draw: (@ctx) ->
    now = new Date().getTime();
    dt = now - (@lastAnimated || now);

    @lastAnimated = now;
    @x += @speed * dt;
    @ctx.beginPath();
    @ctx.arc(@x,@y,4,0,2*Math.PI);
    @ctx.fill();

window.Shot = Shot;