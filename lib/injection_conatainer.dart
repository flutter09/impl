import 'package:chat_application/presentation/bloc/singin_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/remote/api_service.dart';
import 'data/remote/api_service_impl.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/repository/user_repository.dart';

final di = GetIt.instance;

Future<void> init() async {

  di.registerFactory(() => SignInCubit(di.call()));

  di.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(apiService: di.call()));

  di.registerLazySingleton<ApiService>(() => ApiServiceImpl());
}