import 'package:chat_application/base/base_state.dart';

import '../../base/base_cubit.dart';

part 'chat_list_state.dart';

class ChatListCubit extends BaseCubit<BaseState,String> {
  ChatListCubit() : super(BaseInitState(),"");
}
