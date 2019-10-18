import 'package:book/domins.dart';

class MovieDetailModel {
	String code;
	Data data;
	String msg;
	String showMsg;

	MovieDetailModel({this.code, this.data, this.msg, this.showMsg});

	MovieDetailModel.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
/// data 类结构
class Data {
	Movie movie;
	BoxOffice boxOffice;
	String playState;

	Data({this.movie, this.boxOffice, this.playState});

	Data.fromJson(Map<String, dynamic> json) {
		movie = json['basic'] != null ? new Movie.fromJson(json['basic']) : null;
		boxOffice = json['boxOffice'] != null ? new BoxOffice.fromJson(json['boxOffice']) : null;
		playState = json['playState'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.movie != null) {
      data['basic'] = this.movie.toJson();
    }
		if (this.boxOffice != null) {
      data['boxOffice'] = this.boxOffice.toJson();
    }
		data['playState'] = this.playState;
		return data;
	}
}







