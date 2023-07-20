import 'package:chat_application/base/base_state.dart';

import '../../../../base/base_cubit.dart';


class ChatListCubit extends BaseCubit<BaseState,String> {
  ChatListCubit() : super(BaseInitState(),"");
}
