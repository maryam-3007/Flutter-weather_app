

class Hourlyforecastmodel{
  final DateTime dateTime;
  final double temperature;
  final String description;

  Hourlyforecastmodel({
  required this.dateTime,
  required this.temperature,
  required this.description
  });

  factory Hourlyforecastmodel.fromJson(Map<String,dynamic>json){
    return Hourlyforecastmodel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt']*1000),
     temperature: json['main']['temp'],
      description: json['weather'][0]['description']);
  }     
  }
