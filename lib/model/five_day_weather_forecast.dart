
import 'dart:convert';

class FiveDayWeatherForecast {
  final String cod;
  final int message;
  final int cnt;
  final List<ListElement> list;
  final City city;

  FiveDayWeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  // Convert the object into a Map
  Map<String, dynamic> toMap() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': list.map((item) => item.toMap()).toList(),
      'city': city.toMap(),
    };
  }

  // Convert a Map into an object
  factory FiveDayWeatherForecast.fromMap(Map<String, dynamic> map) {
    return FiveDayWeatherForecast(
      cod: map['cod'] as String,
      message: (map['message'] as num).toInt(),
      cnt: map['cnt'] as int,
      list: (map['list'] as List)
          .map((item) => ListElement.fromMap(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),
      city: City.fromMap(
        Map<String, dynamic>.from(map['city'] as Map),
      ),
    );
  }

  // Convert the object into a JSON String
  String toJson() => json.encode(toMap());

  // Convert a JSON String into an object
  factory FiveDayWeatherForecast.fromJson(String source) =>
      FiveDayWeatherForecast.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

// --------------------------------------------------
// CITY
// --------------------------------------------------

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toMap(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as int,
      name: map['name'] as String,
      coord: Coord.fromMap(
        Map<String, dynamic>.from(map['coord'] as Map),
      ),
      country: map['country'] as String,
      population: map['population'] as int,
      timezone: map['timezone'] as int,
      sunrise: map['sunrise'] as int,
      sunset: map['sunset'] as int,
    );
  }
}

// --------------------------------------------------
// COORD
// --------------------------------------------------

class Coord {
  final double lat;
  final double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }

  factory Coord.fromMap(Map<String, dynamic> map) {
    return Coord(
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
    );
  }
}

// --------------------------------------------------
// LIST ELEMENT (ONE FORECAST ENTRY)
// --------------------------------------------------

class ListElement {
  final int dt;
  final Map<String, double> main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Rain? rain;
  final Sys sys;
  final String dtTxt;

  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,
    required this.sys,
    required this.dtTxt,
  });

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'main': main,
      'weather': weather.map((item) => item.toMap()).toList(),
      'clouds': clouds.toMap(),
      'wind': wind.toMap(),
      'visibility': visibility,
      'pop': pop,
      'rain': rain?.toMap(),
      'sys': sys.toMap(),
      'dt_txt': dtTxt,
    };
  }

  factory ListElement.fromMap(Map<String, dynamic> map) {
    return ListElement(
      dt: map['dt'] as int,

      // Convert every numeric value into double
      main: (map['main'] as Map).map(
        (key, value) => MapEntry(
          key as String,
          (value as num).toDouble(),
        ),
      ),

      weather: (map['weather'] as List)
          .map((item) => Weather.fromMap(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),

      clouds: Clouds.fromMap(
        Map<String, dynamic>.from(map['clouds'] as Map),
      ),

      wind: Wind.fromMap(
        Map<String, dynamic>.from(map['wind'] as Map),
      ),

      visibility: map['visibility'] as int,
      pop: (map['pop'] as num).toDouble(),

      // Rain might not exist in every forecast entry
      rain: map['rain'] != null
          ? Rain.fromMap(
              Map<String, dynamic>.from(map['rain'] as Map),
            )
          : null,

      sys: Sys.fromMap(
        Map<String, dynamic>.from(map['sys'] as Map),
      ),

      dtTxt: map['dt_txt'] as String,
    );
  }
}

// --------------------------------------------------
// CLOUDS
// --------------------------------------------------

class Clouds {
  final int all;

  Clouds({required this.all});

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
// RAIN
// --------------------------------------------------

class Rain {
  final double the3H;

  Rain({required this.the3H});

  Map<String, dynamic> toMap() {
    return {
      '3h': the3H,
    };
  }

  factory Rain.fromMap(Map<String, dynamic> map) {
    return Rain(
      the3H: (map['3h'] as num).toDouble(),
    );
  }
}

// --------------------------------------------------
// SYS
// --------------------------------------------------

class Sys {
  final String pod;

  Sys({required this.pod});

  Map<String, dynamic> toMap() {
    return {
      'pod': pod,
    };
  }

  factory Sys.fromMap(Map<String, dynamic> map) {
    return Sys(
      pod: map['pod'] as String,
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
// WIND
// --------------------------------------------------

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  Map<String, dynamic> toMap() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: (map['speed'] as num).toDouble(),
      deg: map['deg'] as int,
      gust: (map['gust'] as num).toDouble(),
    );
  }
}
