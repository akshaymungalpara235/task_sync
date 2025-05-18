import '../../entity/task.dart';
import '../../repositories/task_repository.dart';
import '../base/base_use_case.dart';

class CreateTaskParams {
  final Task task;

  const CreateTaskParams({required this.task});
}

class CreateTaskUseCase implements BaseUseCase<Task, CreateTaskParams> {
  final TaskRepository _repository;

  CreateTaskUseCase(this._repository);

  @override
  Future<Task> call(CreateTaskParams params) async {
    return await _repository.createTask(params.task);
  }
} 