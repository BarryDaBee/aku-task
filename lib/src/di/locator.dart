import 'package:aku_task/src/core/networking/interceptors/logger_interceptor.dart';
import 'package:aku_task/src/features/search/data/client/search_client.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source.dart';
import 'package:aku_task/src/features/search/data/data_sources/search_data_source_impl.dart';
import 'package:aku_task/src/features/search/data/repositories/search_repository_impl.dart';
import 'package:aku_task/src/features/search/domain/repositories/search_repository.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_by_query_use_case.dart';
import 'package:aku_task/src/features/search/domain/use_cases/get_users_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final GetIt locator = GetIt.instance;

void setupDependencies() {
  locator
    ..registerLazySingleton<Logger>(Logger.new)
    ..registerLazySingleton<Dio>(
      () => Dio()
        ..interceptors.add(
          LoggerInterceptor(
            logger: locator(),
          ),
        ),
    )
    ..registerLazySingleton<SearchClient>(() => SearchClient(locator()))
    ..registerLazySingleton<SearchDataSource>(
      () => SearchDataSourceImpl(client: locator()),
    )
    ..registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(dataSource: locator()),
    )
    ..registerLazySingleton<GetUsersUseCase>(
      () => GetUsersUseCase(locator()),
    )
    ..registerLazySingleton<GetUsersByQueryUseCase>(
      () => GetUsersByQueryUseCase(locator()),
    );
}
