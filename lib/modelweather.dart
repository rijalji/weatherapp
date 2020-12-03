

class ModelWeather {
  String cityname;
  final  temp;
  double tempMin;
  double tempMax;
  String desc;
  String date;
  String weather;

  ModelWeather({this.temp,this.tempMax,this.tempMin,this.desc,this.date,this.cityname,this.weather});

  factory ModelWeather.fromJson(Map<String, dynamic>json){
    return ModelWeather(
      cityname: json['name'],
      weather: json['main'],
      temp:json['temp'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      desc: json['description'],
      date:json['dt_txt']
    );
  }
}
