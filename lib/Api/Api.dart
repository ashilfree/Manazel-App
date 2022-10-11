

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart'as getx;
import 'package:manazel_alabrar/Helper/internet.dart';
import 'package:manazel_alabrar/model/User.dart';
export 'Url.dart';
import 'package:provider/provider.dart';



class Api{
  
  Future<dynamic> get(String url,{Map<String,dynamic> queryParams,String token,withAuthorization = true, Completer<dynamic> completer})async{

    final User user = getx.Get.context?.read<User>();

    if(completer == null){
       completer = Completer();
    }

    if(!await connection()){
      bool internetAvailability = await loopCheckInternet(onErrorListener: (){
      },onInterNetAvailAbility: (){
      });
      if(internetAvailability){
        get(url,queryParams: queryParams,withAuthorization: withAuthorization,completer: completer);
      }
      return completer.future;
    }

    try {
      Dio dios = Dio();
      dios.options.headers["Accept"] = "application/json";

      if(token!=null){
        dios.options.headers["Authorization"] = 'Bearer ' + token;
      }

      if(withAuthorization && !user.isNull){
        dios.options.headers["Authorization"] = 'Bearer ' + user.token.accessToken;
      }

      var response = await dios.get(url,queryParameters: queryParams);

      completer.complete(response.data);

    } on DioError catch (error) {

      switch(error.type){

        case DioErrorType.connectTimeout:
          bool internetAvailability = await loopCheckInternet(onErrorListener: (){
          },onInterNetAvailAbility: (){
          });

          if(internetAvailability){
            get(url,queryParams: queryParams,withAuthorization: withAuthorization,completer: completer);
          }
          print("case dio.DioErrorType.CONNECT_TIMEOUT:");
          /// try loop internet
          break;
        case DioErrorType.sendTimeout:
          bool internetAvailability = await loopCheckInternet(onErrorListener: (){
          },onInterNetAvailAbility: (){
          });

          if(internetAvailability){
            get(url,queryParams: queryParams,withAuthorization: withAuthorization,completer: completer);
          }
          print("case dio.DioErrorType.SEND_TIMEOUT:");
          /// try loop internet
          break;
        case DioErrorType.receiveTimeout:
          bool internetAvailability = await loopCheckInternet(onErrorListener: (){
          },onInterNetAvailAbility: (){
          });
          if(internetAvailability){
            get(url,queryParams: queryParams,withAuthorization: withAuthorization,completer: completer);
          }
          print("case dio.DioErrorType.RECEIVE_TIMEOUT:");
          /// try loop internet
          break;
        case DioErrorType.response:
          completer.completeError(error.response?.data);
          print("case dio.DioErrorType.RESPONSE:");
          // TODO: Handle this case.
          break;
        case DioErrorType.cancel:
          completer.completeError(error.response?.data);
          print("case dio.DioErrorType.CANCEL:");
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          completer.completeError(error);
          print("case dio.DioErrorType.DEFAULT:");
          // TODO: Handle this case.
          break;
      }
      print("---------------  " + error.message);
      print("---------------  " + error.error.toString());
      print("---------------  " + error.type.toString());
    } on SocketException catch(err){

      bool internetAvailability = await loopCheckInternet(onErrorListener: (){
      },onInterNetAvailAbility: (){
      });

      if(internetAvailability){
        get(url,queryParams: queryParams,withAuthorization: withAuthorization,completer: completer);
      }
      print("} on SocketException catch(err){");
      /// try loop internet
    }
    return completer.future;
  }




  Future<dynamic> post(String url,{String token,Map<String,dynamic> queryParams,dynamic data,withAuthorization = true, Completer<dynamic> completer})async{

    final User user = getx.Get.context.read<User>();

    if(completer == null){
      completer = Completer();
    }

    if(!await connection()){
      bool internetAvailability = await loopCheckInternet(onErrorListener: (){
      },onInterNetAvailAbility: (){
      });
      if(internetAvailability){
        post(url,data: data,withAuthorization: withAuthorization,completer: completer,queryParams: queryParams);
      }
      // completer.completeError(ApiError.internet());
      return completer.future;
    }

    try {
      Dio dios = Dio();
      dios.options.headers["Accept"] = "application/json";
      dios.options.headers[HttpHeaders.contentTypeHeader] = "application/x-www-form-urlencoded";

      if(token!=null){
        dios.options.headers["Authorization"] = 'Bearer ' + token;
      }else{
        if(withAuthorization && !user.isNull){
          dios.options.headers["Authorization"] = 'Bearer ' + user.token.accessToken;
        }
      }

      var response = await dios.post(url,data: data is String ? data : FormData.fromMap(data),queryParameters: queryParams);
      completer.complete(response.data);

    } on DioError catch (error) {

      switch(error.type){

        case DioErrorType.connectTimeout:
          bool internetAvailability = await loopCheckInternet(onErrorListener: (){
             
          },onInterNetAvailAbility: (){
             
          });
          if(internetAvailability){
            post(url,data: data,withAuthorization: withAuthorization,completer: completer,queryParams: queryParams);
          }
          print("case dio.DioErrorType.CONNECT_TIMEOUT:");
          /// try loop internet
          break;
        case DioErrorType.sendTimeout:
          bool internetAvailability = await loopCheckInternet(onErrorListener: (){
             
          },onInterNetAvailAbility: (){
             
          });

          if(internetAvailability){
            post(url,data: data,withAuthorization: withAuthorization,completer: completer,queryParams: queryParams);
          }
          print("case dio.DioErrorType.SEND_TIMEOUT:");
          /// try loop internet
          break;
        case DioErrorType.receiveTimeout:
          bool internetAvailability = await loopCheckInternet(onErrorListener: (){
             
          },onInterNetAvailAbility: (){
             
          });
          if(internetAvailability){
            post(url,data: data,withAuthorization: withAuthorization,completer: completer,queryParams: queryParams);
          }
          print("case dio.DioErrorType.RECEIVE_TIMEOUT:");
          /// try loop internet
          break;
        case DioErrorType.response:
          completer.completeError(error.response?.data);
          print("case dio.DioErrorType.RESPONSE:");
          // TODO: Handle this case.
          break;
        case DioErrorType.cancel:
          completer.completeError(error.response?.data);
          print("case dio.DioErrorType.CANCEL:");
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          completer.completeError(error);
          print("case dio.DioErrorType.DEFAULT:");
          // TODO: Handle this case.
          break;
      }
      print("---------------  " + error.message);
      print("---------------  " + error.error.toString());
      print("---------------  " + error.type.toString());
    } on SocketException catch(err){

      bool internetAvailability = await loopCheckInternet(onErrorListener: (){
         
      },onInterNetAvailAbility: (){
         
      });

      if(internetAvailability){
        post(url,data: data,withAuthorization: withAuthorization,completer: completer,queryParams: queryParams);
      }
      print("} on SocketException catch(err){");
      /// try loop internet
    }
    return completer.future;
  }



}