import 'package:pp191225/domain/entities/progression/user_progression.dart';

abstract class ProgressionRepository {
  Future<UserProgression> getProgression();
  Future<void> saveProgression(UserProgression progression);
}
