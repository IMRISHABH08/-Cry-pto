import 'package:flutter/foundation.dart';
import 'package:fluttersync/model/grid_column_name.dart';

class Currency {
  final String id;
  final String logoUrl;
  final String name;
  final double price;
  final double oneHourChange;
  final double oneDayChange;
  final double marketCap;
  final int rank;
  final int rankDelta;

  Currency({
    @required this.id,
    @required this.logoUrl,
    @required this.name,
    @required this.price,
    this.oneHourChange,
    @required this.oneDayChange,
    @required this.marketCap,
    @required this.rank,
    @required this.rankDelta,
  });

  factory Currency.fromjson(Map<String, dynamic> map) {
    return Currency(
      id: map['id'],
      logoUrl: map['logo_url'],
      name: map['name'],
      price: double.parse(map['price']),
      oneDayChange: double.parse(map['1d']['price_change_pct']),
      oneHourChange: double.parse(map['1h']['price_change_pct']),
      marketCap: double.parse(map['market_cap']),
      rank: int.parse(map['rank']),
      rankDelta: int.parse(map['rank_delta']),
    );
  }

  toMap() => {
        "id": id,
        "logoUrl": logoUrl,
        "name": name,
        "price": price,
        "oneHourChange": oneHourChange,
        "oneDayChange": oneDayChange,
        "marketCap": marketCap,
        "rank": rank,
        "rankDelta": rankDelta,
      };
}


//sorting the  rows

class CurrencyComparable {
  final CurrencyColumn column;
  final Currency currency;
  CurrencyComparable({
    @required this.column,
    @required this.currency,
  });

  int compareTo(CurrencyComparable otherComparable) {
    final self = currency;
    final other = otherComparable.currency;

    switch (column) {
      case CurrencyColumn.id:
        return self.id.compareTo(other.id);
      case CurrencyColumn.rank:
        return self.rank.compareTo(other.rank);
      case CurrencyColumn.name:
        return self.name.compareTo(other.name);
      case CurrencyColumn.price:
        return self.price.compareTo(other.price);
      case CurrencyColumn.oneHChange:
        return self.oneHourChange.compareTo(other.oneHourChange);
      case CurrencyColumn.oneDChange:
        return self.oneDayChange.compareTo(other.oneDayChange);
      case CurrencyColumn.marketcap:
        return self.marketCap.compareTo(other.marketCap);
    }
  }
}
