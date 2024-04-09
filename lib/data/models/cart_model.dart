class CartModel {
  bool? success;
  CartData? data;

  CartModel({this.success, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CartData {
  String? currencyCode;
  double? totalPrice;
  double? subtotalPrice;
  bool? hasDiscount;
  int? subtotalDiscount;
  int? couponDiscount;
  String? couponDiscountCode;
  String? couponDiscountApplicableTo;
  int? taxValue;
  int? taxRate;
  double? shippingValue;
  int? shippingDiscount;
  Shipping? shipping;
  int? id;
  String? createdAt;
  String? updatedAt;
  String? uuid;
  Null? couponCode;
  List<CartItems>? cartItems;

  CartData(
      {this.currencyCode,
        this.totalPrice,
        this.subtotalPrice,
        this.hasDiscount,
        this.subtotalDiscount,
        this.couponDiscount,
        this.couponDiscountCode,
        this.couponDiscountApplicableTo,
        this.taxValue,
        this.taxRate,
        this.shippingValue,
        this.shippingDiscount,
        this.shipping,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.uuid,
        this.couponCode,
        this.cartItems});

  CartData.fromJson(Map<String, dynamic> json) {
    currencyCode = json['currencyCode'];
    totalPrice = json['totalPrice'];
    subtotalPrice = json['subtotalPrice'];
    hasDiscount = json['hasDiscount'];
    subtotalDiscount = json['subtotalDiscount'];
    couponDiscount = json['couponDiscount'];
    couponDiscountCode = json['couponDiscountCode'];
    couponDiscountApplicableTo = json['couponDiscountApplicableTo'];
    taxValue = json['taxValue'];
    taxRate = json['taxRate'];
    shippingValue = json['shippingValue'];
    shippingDiscount = json['shippingDiscount'];
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    uuid = json['uuid'];
    couponCode = json['couponCode'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currencyCode'] = this.currencyCode;
    data['totalPrice'] = this.totalPrice;
    data['subtotalPrice'] = this.subtotalPrice;
    data['hasDiscount'] = this.hasDiscount;
    data['subtotalDiscount'] = this.subtotalDiscount;
    data['couponDiscount'] = this.couponDiscount;
    data['couponDiscountCode'] = this.couponDiscountCode;
    data['couponDiscountApplicableTo'] = this.couponDiscountApplicableTo;
    data['taxValue'] = this.taxValue;
    data['taxRate'] = this.taxRate;
    data['shippingValue'] = this.shippingValue;
    data['shippingDiscount'] = this.shippingDiscount;
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['uuid'] = this.uuid;
    data['couponCode'] = this.couponCode;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipping {
  int? id;
  double? value;
  String? name;
  int? discount;
  double? valueAfterExchange;

  Shipping(
      {this.id, this.value, this.name, this.discount, this.valueAfterExchange});

  Shipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    name = json['name'];
    discount = json['discount'];
    valueAfterExchange = json['valueAfterExchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['name'] = this.name;
    data['discount'] = this.discount;
    data['valueAfterExchange'] = this.valueAfterExchange;
    return data;
  }
}

class CartItems {
  double? price;
  ProductVariant? productVariant;
  double? priceAfterDiscount;
  int? discountRate;
  bool? hasDiscount;
  List<ItemOptions>? itemOptions;
  double? totalQuantityPrice;
  double? totalQuantityPriceAfterDiscount;
  int? id;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  CartItems(
      {this.price,
        this.productVariant,
        this.priceAfterDiscount,
        this.discountRate,
        this.hasDiscount,
        this.itemOptions,
        this.totalQuantityPrice,
        this.totalQuantityPriceAfterDiscount,
        this.id,
        this.quantity,
        this.createdAt,
        this.updatedAt});

  CartItems.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    productVariant = json['productVariant'] != null
        ? new ProductVariant.fromJson(json['productVariant'])
        : null;
    priceAfterDiscount = json['priceAfterDiscount'];
    discountRate = json['discountRate'];
    hasDiscount = json['hasDiscount'];
    if (json['itemOptions'] != null) {
      itemOptions = <ItemOptions>[];
      json['itemOptions'].forEach((v) {
        itemOptions!.add(new ItemOptions.fromJson(v));
      });
    }
    totalQuantityPrice = json['totalQuantityPrice'];
    totalQuantityPriceAfterDiscount = json['totalQuantityPriceAfterDiscount'];
    id = json['id'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    if (this.productVariant != null) {
      data['productVariant'] = this.productVariant!.toJson();
    }
    data['priceAfterDiscount'] = this.priceAfterDiscount;
    data['discountRate'] = this.discountRate;
    data['hasDiscount'] = this.hasDiscount;
    if (this.itemOptions != null) {
      data['itemOptions'] = this.itemOptions!.map((v) => v.toJson()).toList();
    }
    data['totalQuantityPrice'] = this.totalQuantityPrice;
    data['totalQuantityPriceAfterDiscount'] =
        this.totalQuantityPriceAfterDiscount;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ProductVariant {
  int? id;
  String? name;
  String? imageFileUrl;
  String? slug;
  List<Categories>? categories;
  int? product;

  ProductVariant(
      {this.id,
        this.name,
        this.imageFileUrl,
        this.slug,
        this.categories,
        this.product});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageFileUrl = json['imageFileUrl'];
    slug = json['slug'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageFileUrl'] = this.imageFileUrl;
    data['slug'] = this.slug;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['product'] = this.product;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? imageFileUrl;

  Categories({this.id, this.name, this.imageFileUrl});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageFileUrl = json['imageFileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageFileUrl'] = this.imageFileUrl;
    return data;
  }
}

class ItemOptions {
  int? id;
  String? attribute;
  String? option;

  ItemOptions({this.id, this.attribute, this.option});

  ItemOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attribute = json['attribute'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute'] = this.attribute;
    data['option'] = this.option;
    return data;
  }
}