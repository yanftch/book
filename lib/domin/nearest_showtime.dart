
class NearestShowtime {
  bool isTicket;
  int nearestCinemaCount;
  int nearestShowDay;
  int nearestShowtimeCount;

  NearestShowtime(
      {this.isTicket,
        this.nearestCinemaCount,
        this.nearestShowDay,
        this.nearestShowtimeCount});

  NearestShowtime.fromJson(Map<String, dynamic> json) {
    isTicket = json['isTicket'];
    nearestCinemaCount = json['nearestCinemaCount'];
    nearestShowDay = json['nearestShowDay'];
    nearestShowtimeCount = json['nearestShowtimeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isTicket'] = this.isTicket;
    data['nearestCinemaCount'] = this.nearestCinemaCount;
    data['nearestShowDay'] = this.nearestShowDay;
    data['nearestShowtimeCount'] = this.nearestShowtimeCount;
    return data;
  }
}