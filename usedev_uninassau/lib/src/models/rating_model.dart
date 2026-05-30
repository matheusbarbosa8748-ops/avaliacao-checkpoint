class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  /// Converte um objeto Rating para JSON
  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }

  /// Cria um objeto Rating a partir de um JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'] as int,
    );
  }
}
