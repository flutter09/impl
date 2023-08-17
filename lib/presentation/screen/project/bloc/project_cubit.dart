import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';

import '../../../../domain/repository/project_repository.dart';

class ProjectCubit extends BaseCubit<BaseState, String>{
  final ProjectRepository projectRepository;

  ProjectCubit(this.projectRepository) : super(BaseInitState(),"");
}