import '../../entity/task.dart';
import '../../repositories/task_repository.dart';
import '../base/base_use_case.dart';

class UpdateTaskParams {
  final Task task;

  const UpdateTaskParams({required this.task});
}

class UpdateTaskUseCase implements BaseUseCase<Task, UpdateTaskParams> {
  final TaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  @override
  Future<Task> call(UpdateTaskParams params) async {
    return await _repository.updateTask(params.task);
  }
} 