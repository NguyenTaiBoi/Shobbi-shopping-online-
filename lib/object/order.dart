class OrderProduct {
  int productId;
  int quantity;

  OrderProduct({this.productId, this.quantity});

  Map<String, dynamic> toMap() {
    return {
      "product_id":productId,
      "quantity":quantity
    };
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) => new OrderProduct(
      productId: json["product_id"],
      quantity: json["quantity"]
  );

}