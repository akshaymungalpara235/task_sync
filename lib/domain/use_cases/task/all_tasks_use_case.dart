import '../../entity/task.dart';
import '../../repositories/task_repository.dart';
import '../base/base_use_case.dart';

class AllTasksUseCase implements BaseUseCase<List<Task>, NoParams> {
  final TaskRepository _repository;

  AllTasksUseCase(this._repository);

  @override
  Future<List<Task>> call(NoParams params) async {
    return await _repository.getAllTasks();
  }
} 