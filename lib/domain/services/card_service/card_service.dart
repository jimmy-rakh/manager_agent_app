import 'package:bingo/app/locator.dart';
import 'package:bingo/data/models/card/request/add_card_request.dart';
import 'package:bingo/data/models/card/request/del_card_request.dart';
import 'package:bingo/data/models/card/response/get_card_response.dart';
import 'package:bingo/domain/repositories/card_repository.dart';
import 'package:stacked/stacked.dart';

class CardService with ListenableServiceMixin {
  final CardRepository _cardRepository = getIt<CardRepositoryImpl>();

  CardService() {
    listenToReactiveValues([_cardsList]);
  }

  final ReactiveValue<List<GetCardResponse>> _cardsList = ReactiveValue([]);

  List<GetCardResponse> get cardsList => _cardsList.value;

  getCards() async {
    try {
      final res = await _cardRepository.getCards();
      _cardsList.value = res;
    } catch (e) {
      rethrow;
    }
  }

  addCard(String name, String cardNumber, String ownerName, String cvvNumber,
      String expire) async {
    AddCardRequest request = AddCardRequest(
        name: name, ownerName: ownerName, number: cardNumber, expire: expire);
    try {
      await _cardRepository.addCard(request);
      await getCards();
    } catch (e) {
      rethrow;
    }
  }

  deleteCard(String cardId) async {
    DeleteCardRequest request = DeleteCardRequest(cardId: cardId);
    try {
      await _cardRepository.deleteCard(request);
      await getCards();
    } catch (e) {
      rethrow;
    }
  }
}
