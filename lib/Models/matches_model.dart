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

}