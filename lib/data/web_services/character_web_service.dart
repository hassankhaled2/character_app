import 'package:character_app/constansts/strings.dart';
import 'package:dio/dio.dart';

class CharacterWebServices
{
 late Dio dio;

 CharacterWebServices()
 {
   BaseOptions options =BaseOptions(
     baseUrl: baseurl,
     receiveDataWhenStatusError: true,
     connectTimeout:Duration(minutes: 20*1000),
     receiveTimeout:Duration(minutes: 20*1000),
   );
   dio =Dio(options);
 }
 Future<List<dynamic>>getAllCharacter()
 async{
   try {
     Response response = await dio.get('character');
     print(response.data.toString());
     return response.data['results'];

   }
   catch(e)
   {
   print(e.toString());
   return [];
   }

 }
 Future<List<dynamic>>getCharacterEpisodes(String charName)
 async{
   try {
     Response response = await dio.get('episode',queryParameters: {'name':charName});
     print(response.data.toString());
     return response.data['results'];

   }
   catch(e)
   {
     print(e.toString());
     return [];
   }

 }
}

