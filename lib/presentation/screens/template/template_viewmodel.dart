import 'package:bingo/app/locator.dart';
import 'package:bingo/app/router.dart';
import 'package:bingo/data/models/products/response/cart_model.dart';
import 'package:bingo/data/models/products/response/product_model.dart';
import 'package:bingo/data/models/template/response.dart';
import 'package:bingo/domain/services/templates/templates_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:stacked/stacked.dart';

class TemplateViewModel extends ReactiveViewModel {
  final TemplateService _templateService = getIt();

  List<TextEditingController> productsQuantity = [];
  List<FocusNode> quantityFocus = [];
  List<int> selectedTemplateProductsId = [];
  bool showCheckboxes = false;

  late TemplateResponse template;

  void onReady(TemplateResponse template) {
    this.template = template;
    getData();
  }

  Future<void> getData() async {
    setBusy(true);
    try {
      final template = await _templateService.fetchTemplate(this.template.id!);
      this.template = template;
      settinUpControllers();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  void settinUpControllers() {
    List<TextEditingController> allQuantityCounter = [];
    List<FocusNode> allFocusNodes = [];
    for (var product in template.templateproducts!) {
      allQuantityCounter
          .add(TextEditingController(text: product.quantity.toString()));
      allFocusNodes.add(FocusNode());
    }
    productsQuantity = allQuantityCounter;
    quantityFocus = allFocusNodes;
  }

  onChangeCount(String values, int index, {bool? isIncrement}) {
    int value = productsQuantity[index].text.isEmpty
        ? 1
        : double.parse(productsQuantity[index].text).toInt();
    if (isIncrement != null) {
      isIncrement
          ? value++
          : value == 1
              ? null
              : value--;
    }
    if (values.isEmpty) {
      productsQuantity[index].text = value.toString();
      for (var element in quantityFocus) {
        element.unfocus();
      }
    }
    template.templateproducts![index].quantity = value;
    notifyListeners();
    changeCountInTemplate(index);
  }

  Future<void> changeCountInTemplate(int index) async {
    try {
      await _templateService.changeProductQuantity(
          template.templateproducts![index].id!,
          template.templateproducts![index].quantity!);
    } catch (e) {
      print(e);
    }
  }

  Future<void> onDeleteProduct({Cartproducts? product}) async {
    try {
      await _templateService.deleteTemplateProduct(
          template.id!, product!.product!.id!.toString());
      await _templateService.fetchTemplates();
      await Future.delayed(Durations.medium2);
      await getData();

      notifyListeners();
      await Future.delayed(Durations.medium2);
      await getData();
    } catch (e) {
      print(e);
    }
  }

  void onProductTapped(ProductDto product) {
    if (showCheckboxes) {
      onProductSelect(product.id!);
      return;
    }
    router.push(ProductRoute(incomingNavIndex: 10, incomingProduct: product));
  }

  onProductSelect(int productId) async {
    bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) {
      Vibrate.feedback(FeedbackType.light);
    }
    if (selectedTemplateProductsId.contains(productId)) {
      selectedTemplateProductsId.remove(productId);
      if (selectedTemplateProductsId.isEmpty) showCheckboxes = false;
    } else {
      selectedTemplateProductsId.add(productId);
      showCheckboxes = true;
    }

    notifyListeners();
  }

  void chooseProducts() async {
    final res = await router.push(const SelectorRoute());
    if (res != null) {
      final data = (res as List<ProductDto>).map((e) => e.id!).toList();
      addProducts(data);
    }
  }

  Future<void> addProducts(List<int> products) async {
    try {
      await _templateService.addBulkTemplate(template.id!, products);
      await _templateService.fetchTemplates();
      getData();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteProducts() async {
    try {
      await _templateService.deleteBulkTemplate(
          template.id!, selectedTemplateProductsId);
      await _templateService.fetchTemplates();
      getData();
    } catch (e) {
      print(e);
    }
  }

  void toCheckout() {
    router.push(CheckoutRoute(templateId: template.id));
  }

  Future<void> deleteTemplate() async {
    setBusy(true);
    try {
      await _templateService.deleteTemplate(template.id!);
      await _templateService.fetchTemplates();
      router.back();
    } catch (e) {
      setBusy(false);
      print(e);
    }
  }
}
