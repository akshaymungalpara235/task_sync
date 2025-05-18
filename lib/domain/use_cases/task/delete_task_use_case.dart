import '../../repositories/task_repository.dart';
import '../base/base_use_case.dart';

class DeleteTaskParams {
  final String id;

  const DeleteTaskParams({required this.id});
}

class DeleteTaskUseCase implements BaseUseCase<void, DeleteTaskParams> {
  final TaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  @override
  Future<void> call(DeleteTaskParams params) async {
    await _repository.deleteTask(params.id);
  }
} 