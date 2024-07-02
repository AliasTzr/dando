class Duel {
  final int? id;
  final String sport, championship, nameTeamA, nameTeamB, scoresTeamA, scoresTeamB, dataMatch, timeMatch;
  const Duel({this.id,
    required this.sport,
    required this.championship,
    required this.nameTeamA,
    required this.scoresTeamA,
    required this.nameTeamB,
    required this.scoresTeamB,
    required this.dataMatch,
    required this.timeMatch
  });
  Map<String, dynamic> toJSON() {
    return {
      'sport': sport,
      'championship': championship,
      'nameteama': nameTeamA,
      'scoresteama': scoresTeamA,
      'nameteamb': nameTeamB,
      'scoresteamb': scoresTeamB,
      'datematch' : dataMatch,
      'timematch' : timeMatch,
    };
  }

  factory Duel.fromJSON(Map<String, dynamic> json) {
    return Duel(
      id: json['id'] as int?,
      sport: json['sport'] as String,
      championship: json['championship'] as String,
      nameTeamA: json['nameteama'] as String,
      scoresTeamA: json['scoresteama'] as String,
      nameTeamB: json['nameteamb'] as String,
      scoresTeamB: json['scoresteamb'] as String,
      dataMatch: json['datematch'] as String,
      timeMatch: json['timematch'] as String,
    );
  }

}