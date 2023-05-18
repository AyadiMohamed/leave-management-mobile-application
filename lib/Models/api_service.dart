
import 'package:app_conge/Models/entity/leave_entity.dart';
import 'package:app_conge/Models/entity/logs_entity.dart';
import 'package:app_conge/Models/entity/user_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

import 'entity/contract_entity.dart';
import 'entity/holiday_entity.dart';
import 'entity/typeleave_entity.dart';
import 'response/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://intranet-teamdev.herokuapp.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
      contentType: 'application/json',
    );
    return _ApiService(dio, baseUrl: baseUrl);
  }

  // Login service
  @POST('/signin') // enter your api method
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

  @GET("/vacations/id/{uuid}")
  Future<List<LeaveEntity>> getLeaves(@Path("uuid") String id);

  @GET("/leaveType")
  Future<List<LeaveTypeEntity>> getTypes();

  @POST("/vacations/{uuid}")
  Future<LeaveEntity> addLeave(@Path("uuid") String id , @Body() Map<String, dynamic> body);

  @GET("/collaborators/{uuid}")
  Future<UserEntity> getUser(@Path("uuid") String id, @Header("Authorization") String token);

  @PATCH("/collaborators/updatepassword/{uuid}")
  Future<UserEntity> updatePassword(@Path("uuid") String id , @Body() Map<String, dynamic> body);

  @GET("/vacations/date/{uuid}/{start}/{end}")
  Future<List<LeaveEntity>> getLeavesByDate(@Path("uuid") String id, @Path("start") String start, @Path("end") String end);

  @GET("/vacations/statusandid/{uuid}/{status}")
  Future<List<LeaveEntity>> getLeavesByStatus(@Path("uuid") String id, @Path("status") String status);

  // @GET("/collaborators/{uuid}")
  // Future<HttpResponse<UserEntity>> getUserOriginal(@Path("uuid") String id, @Header("Authorization") String token);
  // Future<HttpResponse<UserEntity>> if you want to access the original HTTP Response (body and statuscode)

   @GET("/holidays")
   Future<List<HolidayEntity>> getHolidays();

   @GET("/balancelogs/{uuid}")
   Future<List<LogsEntity>> getLogs(@Path("uuid") String id);

   @GET("/contracts/id/{uuid}")
   Future<List<ContractEntity>> getUserContracts(@Path("uuid") String id);
}
