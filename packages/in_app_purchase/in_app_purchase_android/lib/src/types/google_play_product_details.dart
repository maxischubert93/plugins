// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_platform_interface/in_app_purchase_platform_interface.dart';

/// The class represents the information of a product as registered in at
/// Google Play store front.
class GooglePlayProductDetails extends ProductDetails {
  /// Creates a new Google Play specific product details object with the
  /// provided details.
  GooglePlayProductDetails({
    required String id,
    required String title,
    required String description,
    required this.productDetails,
  }) : super(
          id: id,
          title: title,
          description: description,
        );

  /// Generate a [GooglePlayProductDetails] object based on an Android
  /// [SkuDetailsWrapper] object.
  factory GooglePlayProductDetails.fromProductDetails(
    ProductDetailsWrapper details,
  ) {
    return GooglePlayProductDetails(
      id: details.productId,
      title: details.title,
      description: details.description,
      productDetails: details,
    );
  }

  /// Points back to the [SkuDetailsWrapper] object that was used to generate
  /// this [GooglePlayProductDetails] object.
  //final SkuDetailsWrapper skuDetails;

  final ProductDetailsWrapper productDetails;
}
