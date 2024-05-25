import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/card/request/add_card_request.dart';
import 'package:bingo/data/models/card/request/del_card_request.dart';
import 'package:bingo/data/models/card/response/get_card_response.dart';
import 'package:bingo/data/sources/network/card_api.dart';

abstract class CardRepository {
  Future<List<GetCardResponse>> getCards();

  Future addCard(AddCardRequest request);

  Future deleteCard(DeleteCardRequest request);
}

class CardRepositoryImpl implements CardRepository {
  final _api = getIt<CardApiImpl>();

  @override
  Future addCard(request) async {
    try {
      await _api.addCard(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteCard(request) async {
    try {
      await _api.deleteCard(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GetCardResponse>> getCards() async {
    try {
      return await _api.getCards();
    } catch (e) {
      rethrow;
    }
  }
}
