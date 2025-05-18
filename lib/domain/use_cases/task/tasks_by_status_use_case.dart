import '../../entity/task.dart';
import '../../repositories/task_repository.dart';
import '../base/base_use_case.dart';

class GetTasksByStatusParams {
  final bool isCompleted;

  const GetTasksByStatusParams({required this.isCompleted});
}

class TasksByStatusUseCase implements BaseUseCase<List<Task>, GetTasksByStatusParams> {
  final TaskRepository _repository;

  TasksByStatusUseCase(this._repository);

  @override
  Future<List<Task>> call(GetTasksByStatusParams params) async {
    return await _repository.getTasksByStatus(params.isCompleted);
  }
} 