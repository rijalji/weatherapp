import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weatherapp/modelweather.dart';
import 'package:geolocator/geolocator.dart';
import 'conditionweather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ConditionWeather conditionWeather = ConditionWeather();
  double longitude;
  double latitude;
  String cityname='Jakarta';
  int temperature;
  String description;
  String icon;
  bool showMarkerCurrentLocation=true;
  String afternooornight;

getCurrentPosition()async{
  try{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      longitude=position.longitude;
      latitude=position.latitude;

  }catch(e){
    throw(e);
  }
 getWeather();
}
    var  data1;
    var  data2;
    String condition;
getCurrentLocation()async{
  var apiKey='207f3899c6e5fcc5b54eb51b5a9aeb76';
  var url='https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=id';
  final response=await http.get(url);
  if(response.statusCode==200){
    data1=jsonDecode(response.body);
    setState(() {
      var conditionweatherid=data1['weather'][0]['id'];
      condition= conditionWeather.getCondition(conditionweatherid);
      double temp=data1['main']['temp'].toDouble();
      cityname=data1['name'];
      temperature=temp.toInt();
      description=data1['weather'][0]['description'];
      icon=data1['weather'][0]['icon'];
      afternooornight=conditionWeather.getIconId(icon);
    });
  }
}

String cityname2;
 getWeather()async{
    var apiKey='207f3899c6e5fcc5b54eb51b5a9aeb76';
    var url='https://api.openweathermap.org/data/2.5/weather?q=$cityname&units=metric&appid=$apiKey&lang=id';
    final response=await http.get(url);
    data2=jsonDecode(response.body);
    double temp=data2['main']['temp'].toDouble();
    setState(() {
      var conditionweatherid=data2['weather'][0]['id'];
      print(conditionweatherid);
      condition = conditionWeather.getCondition(conditionweatherid);
      temperature=temp.toInt();
      cityname=data2['name'];
      description=data2['weather'][0]['description'];
      icon=data2['weather'][0]['icon'];
      print(icon);
      afternooornight=conditionWeather.getIconId(icon);
    });
  }

  TextEditingController searchcity = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    ScreenUtil.init(context,width: 750, height: 1334, allowFontScaling: true);
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child:Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('$condition')
              )
            ),
              child:Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    data2==null ? CircularProgressIndicator() :
                    Container(
                      padding: EdgeInsets.only(left: 20,top: 20,right: 20,bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.4)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                             Text('$temperature°',style: GoogleFonts.spartan(color: Colors.white,fontSize: ScreenUtil().setHeight(100),fontWeight: FontWeight.bold,shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Colors.black
                                )
                              ]),),
                              Image(
                                fit: BoxFit.cover,
                                height: ScreenUtil().setHeight(120),
                                width: ScreenUtil().setWidth(200),
                                image: NetworkImage('http://openweathermap.org/img/wn/$icon.png'),
                              ),
                            ],
                          ),
                          Text('$afternooornight',style: GoogleFonts.spartan(color: Colors.white,fontSize: ScreenUtil().setHeight(40),fontWeight: FontWeight.bold,shadows: <Shadow>[
                            Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3.0,
                                color: Colors.black
                            )
                          ]),),
                          Text('$description',style: GoogleFonts.spartan(color: Colors.white,fontSize: ScreenUtil().setHeight(40),fontWeight: FontWeight.bold,shadows: <Shadow>[
                            Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 3.0,
                                color: Colors.black
                            )
                          ]),),
                          Row(
                            children: <Widget>[
                              showMarkerCurrentLocation ? SizedBox():Icon(
                              Icons.location_on,
                              size: ScreenUtil().setHeight(40),
                              color: Colors.white,
                            ),
                             Text('$cityname',style: GoogleFonts.spartan(color: Colors.white,fontSize: ScreenUtil().setHeight(34),fontWeight: FontWeight.bold,shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Colors.black
                                )
                              ]),),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(27),
                    ),
                    Row(
                      children: <Widget>[
                         InkWell(
                           onTap: (){
                             getCurrentLocation();
                             showMarkerCurrentLocation=false;
                           },
                           child: Icon(Icons.near_me,size: ScreenUtil().setHeight(90),color: Colors.white,),
                         ),
                        Container(
                          height: ScreenUtil().setHeight(80),
                          width: ScreenUtil().setWidth(450),
                          child: TextFormField(
                            onChanged: (value){
                              cityname=value;
                            },
                            controller: searchcity,
                            decoration: InputDecoration(
                                hintText: 'Cari Kota',
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      color: Colors.white,
                      onPressed: (){

                          getWeather();
                        showMarkerCurrentLocation=true;
                      },
                      child: Text('Cari',style: GoogleFonts.poppins(fontSize: ScreenUtil().setHeight(27)),),
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}
