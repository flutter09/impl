import 'package:json_annotation/json_annotation.dart';

part 'req_project_detail.g.dart';

@JsonSerializable()
class ReqProjectDetail {
  @JsonKey(name: 'project_id')
  final String projectId;

  ReqProjectDetail({
    required this.projectId,
  });

  factory ReqProjectDetail.fromJson(Map<String, dynamic> json) => _$ReqProjectDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ReqProjectDetailToJson(this);
}
