import 'package:pp191225/data/datasources/local/progression_local_datasource.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/domain/repositories/progression_repository.dart';

class ProgressionRepositoryImpl implements ProgressionRepository {
  final ProgressionLocalDataSource localDataSource;

  ProgressionRepositoryImpl({required this.localDataSource});

  @override
  Future<UserProgression> getProgression() => localDataSource.getProgression();

  @override
  Future<void> saveProgression(UserProgression progression) =>
      localDataSource.saveProgression(progression);
}
