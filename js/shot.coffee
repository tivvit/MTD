define [], () ->
  class Shot
    constructor: (@x, @y, @ex, @ey, @enemy, @type)->
      @name = "Shot";
      @x *= 30;
      @y *= 30;
      @x += 15;
      @y += 15;
      @ex += 15;
      @ey += 15;
      @xx = @x;
      @yy = @y;
      @hit = false;

      switch @type
        when "Fire" then @type = "red";
        when "Water" then @type = "blue";
        when "Nature" then @type = "green";
        when "Wind" then @type = "white";

      @speed = .6;
      @lastAnimated;

    draw: (ctx) ->
      now = new Date().getTime();
      dt = now - (@lastAnimated || now);

      @lastAnimated = now;

      @xx += ((@ex-@x)*(@speed * dt))/Math.sqrt(Math.pow(@x-@ex,2)+Math.pow(@y-@ey,2));
      @yy += ((@ey-@y)*(@speed * dt))/Math.sqrt(Math.pow(@x-@ex,2)+Math.pow(@y-@ey,2));

      if @x >= @ex
        if @y >= @ey
          if @xx <= @ex && @yy <= @ey
            @hit = true;
        else
          if @xx <= @ex && @yy >= @ey
            @hit = true;
      else
        if @y >= @ey
          if @xx >= @ex && @yy <= @ey
            @hit = true;
        else
          if @xx >= @ex && @yy >= @ey
            @hit = true;

      ctx.beginPath();
      ctx.fillStyle = @type;
      ctx.arc(@xx,@yy,4,0,2*Math.PI);
      ctx.fill();
