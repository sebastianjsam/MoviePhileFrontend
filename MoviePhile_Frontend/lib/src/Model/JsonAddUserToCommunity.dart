class JsonerAddUserToCommunity {
  //I need a JSON representation of:
  int communityId;
  String userId;

  JsonerAddUserToCommunity({this.communityId, this.userId});

  Map<String, dynamic> toJson() =>
      {"communityId": this.communityId, "userId": this.userId};
}