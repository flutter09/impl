import 'package:chat_application/data/local/preference_repository.dart';
import 'package:chat_application/data/local/preference_repository_impl.dart';
import 'package:chat_application/data/repository/group_repository_impl.dart';
import 'package:chat_application/data/repository/project_repository_impl.dart';
import 'package:chat_application/data/repository/save_user_repository_impl.dart';
import 'package:chat_application/domain/repository/group_repository.dart';
import 'package:chat_application/domain/repository/project_repository.dart';
import 'package:chat_application/domain/repository/save_user_repository.dart';
import 'package:chat_application/presentation/screen/group/bloc/group_cubit.dart';
import 'package:chat_application/presentation/screen/login/bloc/forgot_password_cubit.dart';
import 'package:chat_application/presentation/screen/login/bloc/generate_password_cubit.dart';
import 'package:chat_application/presentation/screen/login/bloc/signup_cubit.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_cubit.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_cubit.dart';
import 'package:chat_application/presentation/screen/user/bloc/add_user_cubit.dart';
import 'package:chat_application/presentation/screen/user/bloc/personal_info_cubit.dart';
import 'package:chat_application/presentation/screen/user/bloc/save_user_list_cubit.dart';
import 'package:chat_application/presentation/screen/user/bloc/select_custom_user_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/remote/api_service.dart';
import 'data/remote/api_service_impl.dart';
import 'data/repository/user_repository_impl.dart';
import 'domain/repository/user_repository.dart';

final di = GetIt.instance;

Future<void> init() async {

  di.registerFactory(() => SignInCubit(di.call(),di.call()));
  di.registerFactory(() => SignUpCubit(di.call(),di.call()));
  di.registerFactory(() => ForgotPasswordCubit(di.call(),di.call()));
  di.registerFactory(() => GeneratePasswordCubit(di.call()));
  di.registerFactory(() => PersonalInfoCubit(di.call(),di.call()));
  di.registerFactory(() => AddUserCubit(di.call()));
  di.registerFactory(() => SaveUserListCubit(di.call()));
  di.registerFactory(() => ProjectCubit(di.call() , di.call()));
  di.registerFactory(() => SelectCustomUserCubit(di.call()));
  di.registerFactory(() => GroupCubit(di.call(),di.call()));

  di.registerLazySingleton<PreferenceRepository>(()=>PreferenceRepositoryImpl());
  di.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(apiService: di.call()));
  di.registerLazySingleton<SaveUserRepository>(() => SaveUserRepositoryImpl(apiService: di.call()));
  di.registerLazySingleton<ProjectRepository>(() => ProjectRepositoryImpl(apiService: di.call()));
  di.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(apiService: di.call()));

  di.registerLazySingleton<ApiService>(() => ApiServiceImpl());
}