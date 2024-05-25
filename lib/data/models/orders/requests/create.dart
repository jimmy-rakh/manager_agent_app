class CreateOrderDto {
  int? addressId;
  String? time;
  int? pickupPointId;

  CreateOrderDto({
    this.addressId,
    this.time,
    this.pickupPointId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressId != null) data['address_id'] = addressId;
    if (pickupPointId != null) data['pickup_point_id'] = pickupPointId;
    data['delivery_time'] = time;
    return data;
  }
}
