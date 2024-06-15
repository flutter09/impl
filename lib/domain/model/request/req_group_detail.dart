


class ReqGroupDetail {
  final String groupId;

  ReqGroupDetail({
    required this.groupId,
  });

  factory ReqGroupDetail.fromJson(Map<String, dynamic> json) => _$ReqGroupDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ReqGroupDetailToJson(this);
}
ReqGroupDetail _$ReqGroupDetailFromJson(Map<String, dynamic> json) =>
    ReqGroupDetail(
      groupId: json['group_id'] as String,
    );

Map<String, dynamic> _$ReqGroupDetailToJson(ReqGroupDetail instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
    };