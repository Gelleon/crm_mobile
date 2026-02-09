// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:sqflite/sqflite.dart' as _i779;

import '../../features/clients/data/datasources/clients_local_datasource.dart'
    as _i563;
import '../../features/clients/data/datasources/interactions_local_datasource.dart'
    as _i1066;
import '../../features/clients/data/repositories/clients_repository_impl.dart'
    as _i365;
import '../../features/clients/data/repositories/interactions_repository_impl.dart'
    as _i17;
import '../../features/clients/domain/repositories/clients_repository.dart'
    as _i704;
import '../../features/clients/domain/repositories/interactions_repository.dart'
    as _i922;
import '../../features/deals/data/datasources/deals_local_datasource.dart'
    as _i269;
import '../../features/deals/data/repositories/deals_repository_impl.dart'
    as _i274;
import '../../features/deals/domain/repositories/deals_repository.dart'
    as _i764;
import '../../features/deals/services/draft_service.dart' as _i226;
import '../../features/documents/services/excel_service.dart' as _i241;
import '../../features/documents/services/pdf_service.dart' as _i718;
import '../data/local_database.dart' as _i463;
import '../services/auth_service.dart' as _i745;
import '../services/biometric_service.dart' as _i374;
import '../services/calendar_service.dart' as _i1004;
import '../services/notification_service.dart' as _i941;
import '../services/openai_service.dart' as _i958;
import '../services/secure_storage_service.dart' as _i535;
import '../services/speech_service.dart' as _i902;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i779.Database>(
      () => databaseModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i374.BiometricService>(() => _i374.BiometricService());
    gh.lazySingleton<_i1004.CalendarService>(() => _i1004.CalendarService());
    gh.lazySingleton<_i941.NotificationService>(
        () => _i941.NotificationService());
    gh.lazySingleton<_i535.SecureStorageService>(
        () => _i535.SecureStorageService());
    gh.lazySingleton<_i902.SpeechService>(() => _i902.SpeechService());
    gh.lazySingleton<_i241.ExcelService>(() => _i241.ExcelService());
    gh.lazySingleton<_i718.PdfService>(() => _i718.PdfService());
    gh.lazySingleton<_i745.AuthService>(() => _i745.AuthService());
    gh.lazySingleton<_i226.DraftService>(() => _i226.DraftService());
    gh.lazySingleton<_i269.DealsLocalDataSource>(
        () => _i269.DealsLocalDataSourceImpl(gh<_i779.Database>()));
    gh.lazySingleton<_i1066.InteractionsLocalDataSource>(
        () => _i1066.InteractionsLocalDataSourceImpl(gh<_i779.Database>()));
    gh.lazySingleton<_i958.OpenAIService>(
        () => _i958.OpenAIService(gh<_i361.Dio>()));
    gh.lazySingleton<_i563.ClientsLocalDataSource>(
        () => _i563.ClientsLocalDataSourceImpl(gh<_i779.Database>()));
    gh.lazySingleton<_i922.InteractionsRepository>(() =>
        _i17.InteractionsRepositoryImpl(
            gh<_i1066.InteractionsLocalDataSource>()));
    gh.lazySingleton<_i764.DealsRepository>(
        () => _i274.DealsRepositoryImpl(gh<_i269.DealsLocalDataSource>()));
    gh.lazySingleton<_i704.ClientsRepository>(
        () => _i365.ClientsRepositoryImpl(gh<_i563.ClientsLocalDataSource>()));
    return this;
  }
}

class _$DatabaseModule extends _i463.DatabaseModule {}

class _$NetworkModule extends _i567.NetworkModule {}
