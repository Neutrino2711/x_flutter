import 'dart:io';

import 'package:dio/dio.dart';

import 'package:x/constants/constants.dart';

class AuthRepository {
  final Dio dio;
  AuthRepository({required this.dio});

  Future<String> login (String email,String password) async {
    try{
      final response = await dio.post(
        UserApiConstants.login,
        data: {
          'email': email,
          'password': password
        },
      );
      return response.data['token'];
    } on DioException catch(e){
      if (e.response != null && 
          e.response!.data != null && 
          e.response!.data['non_field_errors'] != null && 
          e.response!.data['non_field_errors'].length > 0) {
        final String error = e.response!.data['non_field_errors'][0];
        throw Exception(error);
      } else {
        throw Exception('An error occurred');
      }
    }
  }

  Future<void> register (
    {required String email ,
    required String password,
    String? name,
    File? profile_pic


    }) async {
      try{
        await dio.post(
          UserApiConstants.create,
          data: FormData.fromMap({
            "email":email,
            "password":password,  
            "name":name,
           "profile_pic": profile_pic != null
              ? await MultipartFile.fromFile(
                  profile_pic.path,
                )
              : null,

          })
        

        );
        print("post done");
      } on DioException catch(e)
      {
        
        print(e);
      }
    }

}