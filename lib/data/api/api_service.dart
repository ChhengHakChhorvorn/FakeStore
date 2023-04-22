import 'package:dio/dio.dart';
import 'package:fake_store/data/response/product_response.dart';
import 'package:fake_store/data/response/user_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://fakestoreapi.com/')
abstract class ApiService {
  factory ApiService({String? baseUrl}) {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
    dio.options = BaseOptions(
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @GET('products')
  Future<List<Product>> getProduct();

  @GET('users')
  Future<List<UserResponse>> getUsers();
}
