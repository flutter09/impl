


class ReqProjectDetail {
  final String projectId;

  ReqProjectDetail({
    required this.projectId,
  });

  factory ReqProjectDetail.fromJson(Map<String, dynamic> json) => _$ReqProjectDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ReqProjectDetailToJson(this);
}

ReqProjectDetail _$ReqProjectDetailFromJson(Map<String, dynamic> json) =>
    ReqProjectDetail(
      projectId: json['project_id'] as String,
    );

Map<String, dynamic> _$ReqProjectDetailToJson(ReqProjectDetail instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
    };