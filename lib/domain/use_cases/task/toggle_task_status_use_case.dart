import '../../repositories/task_repository.dart';
import '../base/base_use_case.dart';

class ToggleTaskStatusParams {
  final String id;

  const ToggleTaskStatusParams({required this.id});
}

class ToggleTaskStatusUseCase implements BaseUseCase<void, ToggleTaskStatusParams> {
  final TaskRepository _repository;

  ToggleTaskStatusUseCase(this._repository);

  @override
  Future<void> call(ToggleTaskStatusParams params) async {
    await _repository.toggleTaskStatus(params.id);
  }
} 