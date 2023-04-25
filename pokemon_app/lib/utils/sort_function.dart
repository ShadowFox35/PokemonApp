import 'package:pokemon_app/repositories/models/models_export.dart';

int? _extractNumberFromUrl(String? url) {
  if (url != null) {
    List numberStr = url.split("/");
    int? number = int.tryParse(numberStr[numberStr.length - 2]);
    return number;
  }
  return null;
}

List<PokemonListModel> sortListByUrlNumber(list) {
  list.sort((a, b) {
    int? numA = _extractNumberFromUrl(a?.url);
    int? numB = _extractNumberFromUrl(b?.url);
    if (numA != null && numB != null) {
      return numA.compareTo(numB);
    } else {
      return 0;
    }
  });
  return list;
}
