

class Dailyforecastmodel{


  final DateTime date;
  final double dayTemp;
 final double minTemp;
 final double maxTemp;
  final String description;

  Dailyforecastmodel({
    
    required this.date,
    required this.dayTemp,
    required this.minTemp,
     required this.maxTemp,
      required this.description
  });

  factory Dailyforecastmodel.fromJson(Map<String,dynamic>json){
    return Dailyforecastmodel(
     
      date: DateTime.fromMillisecondsSinceEpoch(json['dt']*1000),
     dayTemp: json['temp']['day'].toDouble(),
   minTemp: json['temp']['min'],
    maxTemp: json['temp']['max'],
        description: json['weather'][0]['description']);
  }

}