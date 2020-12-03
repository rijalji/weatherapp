import 'package:flutter/material.dart';

class ConditionWeather{

  String  getCondition(int cond){
    if(cond <= 232 ){
//      https://www.pexels.com/photo/thunder-striking-a-building-photo-680940/
      return 'assets/storm.jpg';
    }else if (cond <= 321){
//      https://www.pexels.com/photo/background-blur-clean-clear-531880/
      return 'assets/drizzle.jpg';
    }else if (cond <= 531){
//      https://www.pexels.com/photo/raining-in-the-city-2448749/
      return 'assets/rain.jpg';
    }else if (cond <= 622){
//      https://www.pexels.com/photo/photography-of-roadway-during-winter-1032654/
      return 'assets/snow.jpg';
    }else if(cond <= 781){
//    https://www.pexels.com/photo/chain-bridge-over-danube-river-4913366/
      return 'assets/mist.jpg';
    } else if ( cond == 800 ){
//      https://www.pexels.com/photo/photo-of-blue-sky-912110/
      return 'assets/clearsky.jpg';
    }else if(cond >= 801){
//      https://www.pexels.com/photo/nature-sky-clouds-blue-53594/
      return 'assets/clouds.jpg';
    }
  }

  String getIconId(String iconid){
    if(iconid=='01n'){
      return 'Malam';
    }else if(iconid=='02n'){
      return 'Malam';
    }else if(iconid=='03n'){
      return 'Malam';
    }else if(iconid=='04n'){
      return 'Malam';
    }else if(iconid=='09n'){
      return 'Malam';
    }else if(iconid=='10n'){
      return 'Malam';
    }else if(iconid=='11n'){
      return 'Malam';
    }else if(iconid=='13n'){
      return 'Malam';
    }else if(iconid=='50n'){
      return 'Malam';
    }else{
      return '';
    }
  }
}
