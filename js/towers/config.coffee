define [], () ->
  fire = {};
  fire['name'] = "Fire";
  fire['img'] = "img/fire.svg";
  fire['attack'] = 2;
  fire['speed'] = 1000;
  fire['range'] = 4;
  fire['price'] = 30;

  water = {};
  water['name'] = "Water";
  water['img'] = "img/water.svg";
  water['attack'] = 5;
  water['speed'] = 2000;
  water['range'] = 2;
  water['price'] = 50;

  nature = {};
  nature['name'] = "Nature";
  nature['img'] = "img/leaf.svg";
  nature['attack'] = 1;
  nature['speed'] = 2000;
  nature['range'] = 6;
  nature['price'] = 10;

  wind = {};
  wind['name'] = "Wind";
  wind['img'] = "img/wind.svg";
  wind['attack'] = 7;
  wind['speed'] = 5000;
  wind['range'] = 4;
  wind['price'] = 60;

  T = {}
  T['water'] = water;
  T['fire'] = fire;
  T['nature'] = nature;
  T['wind'] = wind;
  T['price'] = wind;

  return T

