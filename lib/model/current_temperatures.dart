
class CurrentTemperatures {
  final Coord coord;
  final List<Weather> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  CurrentTemperatures({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  // Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'coord': coord.toMap(),
      'weather': weather.map((item) => item.toMap()).toList(),
      'base': base,
      'main': main.toMap(),
      'visibility': visibility,
      'wind': wind.toMap(),
      'clouds': clouds.toMap(),
      'dt': dt,
      'sys': sys.toMap(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }

  // Convert Map to object
  factory CurrentTemperatures.fromMap(Map<String, dynamic> map) {
    return CurrentTemperatures(
      coord: Coord.fromMap(
        Map<String, dynamic>.from(map['coord'] as Map),
      ),

      weather: (map['weather'] as List)
          .map((item) => Weather.fromMap(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),

      base: map['base'] as String,

      main: Main.fromMap(
        Map<String, dynamic>.from(map['main'] as Map),
      ),

      visibility: map['visibility'] as int,

      wind: Wind.fromMap(
        Map<String, dynamic>.from(map['wind'] as Map),
      ),

      clouds: Clouds.fromMap(
        Map<String, dynamic>.from(map['clouds'] as Map),
      ),

      dt: map['dt'] as int,

      sys: Sys.fromMap(
        Map<String, dynamic>.from(map['sys'] as Map),
      ),

      timezone: map['timezone'] as int,
      id: map['id'] as int,
      name: map['name'] as String,

      // API might return cod as an integer or string
      cod: (map['cod'] as num).toInt(),
    );
  }
}

// --------------------------------------------------
// COORD
// --------------------------------------------------

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  Map<String, dynamic> toMap() {
    return {
      'lon': lon,
      'lat': lat,
    };
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    return Coord(
      lon: (map['lon'] as num).toDouble(),
      lat: (map['lat'] as num).toDouble(),
    );
  }
}

// --------------------------------------------------
// WEATHER
// --------------------------------------------------

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }
}

// --------------------------------------------------
// MAIN (TEMPERATURE INFORMATION)
// --------------------------------------------------

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }

  factory Main.fromMap(Map<String, dynamic> map) {
    return Main(
      temp: (map['temp'] as num).toDouble(),
      feelsLike: (map['feels_like'] as num).toDouble(),
      tempMin: (map['temp_min'] as num).toDouble(),
      tempMax: (map['temp_max'] as num).toDouble(),
      pressure: map['pressure'] as int,
      humidity: map['humidity'] as int,
      seaLevel: map['sea_level'] as int,
      grndLevel: map['grnd_level'] as int,
    );
  }
}

// --------------------------------------------------
// WIND
// --------------------------------------------------

class Wind {
  final double speed;
  final int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  Map<String, dynamic> toMap() {
    return {
      'speed': speed,
      'deg': deg,
    };
  }

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: (map['speed'] as num).toDouble(),
      deg: map['deg'] as int,
    );
  }
}

// --------------------------------------------------
// CLOUDS
// --------------------------------------------------

class Clouds {
  final int all;

  Clouds({
    required this.all,
  });

  Map<String, dynamic> toMap() {
    return {
      'all': all,
    };
  }

  factory Clouds.fromMap(Map<String, dynamic> map) {
    return Clouds(
      all: map['all'] as int,
    );
  }
}

// --------------------------------------------------
// SYS
// --------------------------------------------------

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      type: map['type'] as int,
      id: map['id'] as int,
      country: map['country'] as String,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
    );
  }
}
