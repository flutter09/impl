import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../data/repository/common_repository.dart';

class DashboardCubit extends BaseCubit<BaseState, String> {
  final CommonRepository commonRepository;
  DashboardCubit(this.commonRepository) : super(BaseInitState(), "");


}