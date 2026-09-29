import 'package:dio/dio.dart';
class Api {
  Api():dio=Dio(BaseOptions(baseUrl:const String.fromEnvironment('API_BASE_URL',defaultValue:'https://furless.example.com/api/v1'),connectTimeout:const Duration(seconds:20),receiveTimeout:const Duration(seconds:30),headers:{'Accept':'application/json','Content-Type':'application/json'}));
  final Dio dio;
  Future<Map<String,dynamic>> bootstrap() async => Map<String,dynamic>.from((await dio.get('/public/bootstrap')).data as Map);
  Future<Map<String,dynamic>> enquiry(Map<String,dynamic> body) async => Map<String,dynamic>.from((await dio.post('/public/enquiry',data:body)).data as Map);
}
