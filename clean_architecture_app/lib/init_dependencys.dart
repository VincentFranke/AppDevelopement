import 'package:clean_architecture_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_architecture_app/core/secrets/supabase_secrets.dart';
import 'package:clean_architecture_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_app/features/auth/domain/usecases/current_user.dart';
import 'package:clean_architecture_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:clean_architecture_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencys() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignIn(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
