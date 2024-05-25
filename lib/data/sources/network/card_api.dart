import 'package:bingo/app/locator.dart';
import 'package:bingo/core/network/constants.dart';
import 'package:bingo/core/network/globuskans_api_service.dart';
import 'package:bingo/data/models/card/request/add_card_request.dart';
import 'package:bingo/data/models/card/request/del_card_request.dart';
import 'package:bingo/data/models/card/response/get_card_response.dart';

abstract class CardApi {
  Future<List<GetCardResponse>> getCards();

  Future addCard(AddCardRequest request);

  Future deleteCard(DeleteCardRequest request);
}

class CardApiImpl extends CardApi {
  final BingoApi _bingoApi = getIt();

  @override
  Future addCard(AddCardRequest request) async {
    try {
      await _bingoApi.post(NetworkConstants.card, data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future deleteCard(DeleteCardRequest request) async {
    try {
      await _bingoApi.delete(NetworkConstants.card,
          data: request.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GetCardResponse>> getCards() async {
    try {
      final res = await _bingoApi.get(NetworkConstants.card);
      final myList = List.from(res).map((e) => GetCardResponse.fromJson(e)).toList();
      return myList;
    } catch (e) {
      rethrow;
    }
  }
}
