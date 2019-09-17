


class MovieCommentModel {
  String code;
  DataInfo data;
  String msg;
  String showMsg;

  MovieCommentModel({this.code, this.data, this.msg, this.showMsg});

  MovieCommentModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new DataInfo.fromJson(json['data']) : null;
    msg = json['msg'];
    showMsg = json['showMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    data['showMsg'] = this.showMsg;
    return data;
  }
}

class DataInfo {
  int commentTotalCount;
  String commentTotalCountShow;
  Mini mini;
  Plus plus;

  DataInfo(
      {this.commentTotalCount,
      this.commentTotalCountShow,
      this.mini,
      this.plus});

  DataInfo.fromJson(Map<String, dynamic> json) {
    commentTotalCount = json['commentTotalCount'];
    commentTotalCountShow = json['commentTotalCountShow'];
    mini = json['mini'] != null ? new Mini.fromJson(json['mini']) : null;
    plus = json['plus'] != null ? new Plus.fromJson(json['plus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentTotalCount'] = this.commentTotalCount;
    data['commentTotalCountShow'] = this.commentTotalCountShow;
    if (this.mini != null) {
      data['mini'] = this.mini.toJson();
    }
    if (this.plus != null) {
      data['plus'] = this.plus.toJson();
    }
    return data;
  }
}

class Mini {
  List<Comment> list;
  int total;

  Mini({this.list, this.total});

  Mini.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<Comment>();
      json['list'].forEach((v) {
        list.add(new Comment.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Comment {
  int commentDate;
  int commentId;
  String content;
  String headImg;
  String img;
  bool isHot;
  bool isPraise;
  String locationName;
  String nickname;
  int praiseCount;
  int rating;
  int replyCount;

  Comment(
      {this.commentDate,
      this.commentId,
      this.content,
      this.headImg,
      this.img,
      this.isHot,
      this.isPraise,
      this.locationName,
      this.nickname,
      this.praiseCount,
      this.rating,
      this.replyCount});

  Comment.fromJson(Map<String, dynamic> json) {
    commentDate = json['commentDate'];
    commentId = json['commentId'];
    content = json['content'];
    headImg = json['headImg'];
    img = json['img'];
    isHot = json['isHot'];
    isPraise = json['isPraise'];
    locationName = json['locationName'];
    nickname = json['nickname'];
    praiseCount = json['praiseCount'];
    rating = json['rating'];
    replyCount = json['replyCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentDate'] = this.commentDate;
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['headImg'] = this.headImg;
    data['img'] = this.img;
    data['isHot'] = this.isHot;
    data['isPraise'] = this.isPraise;
    data['locationName'] = this.locationName;
    data['nickname'] = this.nickname;
    data['praiseCount'] = this.praiseCount;
    data['rating'] = this.rating;
    data['replyCount'] = this.replyCount;
    return data;
  }
}

class Plus {
  bool clientPublish;
  List<Comment> list;
  int total;

  Plus({this.clientPublish, this.list, this.total});

  Plus.fromJson(Map<String, dynamic> json) {
    clientPublish = json['clientPublish'];
    if (json['list'] != null) {
      list = new List<Comment>();
      json['list'].forEach((v) {
        list.add(new Comment.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientPublish'] = this.clientPublish;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}