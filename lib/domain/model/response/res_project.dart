

class ProjectList {
  List<Project>? project;
  int? totalUnreadCount;

  ProjectList({this.project, this.totalUnreadCount});

  ProjectList.fromJson(Map<String, dynamic> json) {
    if (json['project'] != null) {
      project = <Project>[];
      json['project'].forEach((v) {
        project!.add(Project.fromJson(v));
      });
    }
    totalUnreadCount = json['totalunreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project != null) {
      data['project'] = this.project!.map((v) => v.toJson()).toList();
    }
    data['totalunreadCount'] = this.totalUnreadCount;
    return data;
  }
}

class OurProjectList {
  List<Project>? project;
  int? totalunreadCount;

  OurProjectList({this.project, this.totalunreadCount});

  OurProjectList.fromJson(Map<String, dynamic> json) {
    if (json['ourProject'] != null) {
      project = <Project>[];
      json['ourProject'].forEach((v) {
        project!.add(new Project.fromJson(v));
      });
    }
    totalunreadCount = json['totalunreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project != null) {
      data['ourProject'] = this.project!.map((v) => v.toJson()).toList();
    }
    data['totalunreadCount'] = this.totalunreadCount;
    return data;
  }
}

class FavouriteProjectList {
  List<Project>? project;
  int? totalunreadCount;

  FavouriteProjectList({this.project, this.totalunreadCount});

  FavouriteProjectList.fromJson(Map<String, dynamic> json) {
    if (json['favouriteProject'] != null) {
      project = <Project>[];
      json['favouriteProject'].forEach((v) {
        project!.add(new Project.fromJson(v));
      });
    }
    totalunreadCount = json['totalunreadCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project != null) {
      data['favouriteProject'] = this.project!.map((v) => v.toJson()).toList();
    }
    data['totalunreadCount'] = this.totalunreadCount;
    return data;
  }
}

class Project {
  String? sId;
  String? name;
  List<String>? groupsId;
  String? image;
  String? description;
  String? createBy;
  List<ProjectMember>? projectMembers;
  String? createdAt;
  String? updatedAt;
  int? uniqueId;
  List<GroupDetails>? groupDetails;

  Project(
      {this.sId,
        this.name,
        this.groupsId,
        this.image,
        this.description,
        this.createBy,
        this.projectMembers,
        this.createdAt,
        this.updatedAt,
        this.uniqueId,
        this.groupDetails});

  Project.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    groupsId = json['groups_id'].cast<String>();
    image = json['image'];
    description = json['description'];
    createBy = json['create_by'];
    if (json['project_members'] != null) {
      projectMembers = <ProjectMember>[];
      json['project_members'].forEach((v) {
        projectMembers!.add(ProjectMember.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    uniqueId = json['unique_id'];
    if (json['group_details'] != null) {
      groupDetails = <GroupDetails>[];
      json['group_details'].forEach((v) {
        groupDetails!.add(GroupDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['groups_id'] = this.groupsId;
    data['image'] = this.image;
    data['description'] = this.description;
    data['create_by'] = this.createBy;
    if (projectMembers != null) {
      data['project_members'] =
          this.projectMembers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['unique_id'] = this.uniqueId;
    if (this.groupDetails != null) {
      data['group_details'] =
          this.groupDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectMember {
  String? userId;
  String? userName;
  String? chatName;
  String? role;
  String? addedByUserId;
  String? sId;

  ProjectMember(
      {this.userId,
        this.userName,
        this.chatName,
        this.role,
        this.addedByUserId,
        this.sId});

  ProjectMember.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['userName'];
    chatName = json['chatName'];
    role = json['role'];
    addedByUserId = json['added_by_user_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['userName'] = this.userName;
    data['chatName'] = this.chatName;
    data['role'] = this.role;
    data['added_by_user_id'] = this.addedByUserId;
    data['_id'] = this.sId;
    return data;
  }
}

class GroupDetails {
  String? sId;
  String? name;
  String? description;
  List<ProjectMember>? groupMembers;
  String? image;
  String? projectId;
  String? createBy;
  List<ProjectMember>? removedGroupMembers;
  String? createdAt;
  String? updatedAt;
  int? uniqueId;
  int? iV;
  int? unreadMsgCount;

  GroupDetails(
      {this.sId,
        this.name,
        this.description,
        this.groupMembers,
        this.image,
        this.projectId,
        this.createBy,
        this.removedGroupMembers,
        this.createdAt,
        this.updatedAt,
        this.uniqueId,
        this.iV,
        this.unreadMsgCount});

  GroupDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    if (json['group_members'] != null) {
      groupMembers = <ProjectMember>[];
      json['group_members'].forEach((v) {
        groupMembers!.add(new ProjectMember.fromJson(v));
      });
    }
    image = json['image'];
    projectId = json['project_id'];
    createBy = json['create_by'];
    if (json['removed_group_members'] != null) {
      removedGroupMembers = <ProjectMember>[];
      json['removed_group_members'].forEach((v) {
        removedGroupMembers!.add(new ProjectMember.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    uniqueId = json['unique_id'];
    iV = json['__v'];
    unreadMsgCount = json['unreadMsgCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.groupMembers != null) {
      data['group_members'] =
          this.groupMembers!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['project_id'] = this.projectId;
    data['create_by'] = this.createBy;
    if (this.removedGroupMembers != null) {
      data['removed_group_members'] =
          this.removedGroupMembers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['unique_id'] = this.uniqueId;
    data['__v'] = this.iV;
    data['unreadMsgCount'] = this.unreadMsgCount;
    return data;
  }
}
