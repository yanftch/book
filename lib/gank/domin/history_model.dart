import 'history.dart';

class HistoryModel {
  String reason;
  List<History> historys;
  int errorCode;

  HistoryModel({this.reason, this.historys, this.errorCode});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
      historys = new List<History>();
    if (json['result'] != null) {
      json['result'].forEach((v) {
        historys.add(new History.fromJson(v));
      });
    }
    errorCode = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    if (this.historys != null) {
      data['result'] = this.historys.map((v) => v.toJson()).toList();
    }
    data['error_code'] = this.errorCode;
    return data;
  }
}
