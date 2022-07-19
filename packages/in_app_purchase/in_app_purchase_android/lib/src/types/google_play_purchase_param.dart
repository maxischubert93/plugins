// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

/// Google Play specific parameter object for generating a purchase.
class GooglePlayPurchaseParam extends PurchaseParam {
  /// Creates a new [GooglePlayPurchaseParam] object with the given data.
  GooglePlayPurchaseParam({
    required ProductDetails productDetails,
    required this.offerToken,
    String? applicationUserName,
  }) : super(
          productDetails: productDetails,
          applicationUserName: applicationUserName,
        );

  /// The offerToken identifying the specific offer to buy from the product
  final String offerToken;
}
