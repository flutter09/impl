import 'package:json_annotation/json_annotation.dart';

part 'req_group_detail.g.dart';

@JsonSerializable()
class ReqGroupDetail {
  @JsonKey(name: 'group_id')
  final String groupId;

  ReqGroupDetail({
    required this.groupId,
  });

  factory ReqGroupDetail.fromJson(Map<String, dynamic> json) => _$ReqGroupDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ReqGroupDetailToJson(this);
}
