import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../billing_client_wrappers.dart';

part 'product_details_wrapper.g.dart';

/// Dart wrapper around [`com.android.billingclient.api.SkuDetails`](https://developer.android.com/reference/com/android/billingclient/api/SkuDetails).
///
/// Contains the details of an available product in Google Play Billing.
@JsonSerializable()
@SkuTypeConverter()
@immutable
class ProductDetailsWrapper {
  /// Creates a [ProductDetailsWrapper] with the given purchase details.
  @visibleForTesting
  const ProductDetailsWrapper({
    required this.title,
    required this.description,
    required this.subscriptionOfferDetails,
    required this.oneTimePurchaseOfferDetails,
    required this.productId,
    required this.name,
    required this.productType,
  });

  /// Constructs an instance of this from a key value map of data.
  ///
  /// The map needs to have named string keys with values matching the names and
  /// types of all of the members on this class.
  @visibleForTesting
  factory ProductDetailsWrapper.fromJson(Map<String, dynamic> map) =>
      _$ProductDetailsWrapperFromJson(map);

  /// Textual description of the product.
  @JsonKey(defaultValue: '')
  final String title;

  /// Textual description of the product.
  @JsonKey(defaultValue: '')
  final String description;

  /// Textual description of the product.
  @JsonKey(defaultValue: '')
  final String productId;

  /// Textual description of the product.
  @JsonKey(defaultValue: '')
  final String name;

  /// Textual description of the product.
  @JsonKey(defaultValue: '')
  final String productType;

  /// A list of [ProductDetailsWrapper] matching the query to [BillingClient.querySkuDetails].
  @JsonKey(defaultValue: <SubscriptionOfferDetails>[])
  final List<SubscriptionOfferDetails> subscriptionOfferDetails;

  /// Trial period in ISO 8601 format.
  @JsonKey(defaultValue: <OneTimePurchaseOfferDetails>[])
  final List<OneTimePurchaseOfferDetails> oneTimePurchaseOfferDetails;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ProductDetailsWrapper &&
        other.title == title &&
        other.description == description &&
        other.subscriptionOfferDetails == subscriptionOfferDetails &&
        other.oneTimePurchaseOfferDetails == oneTimePurchaseOfferDetails &&
        other.productId == productId &&
        other.name == name &&
        other.productType == productType;
  }

  @override
  int get hashCode {
    return Object.hash(
      title.hashCode,
      description.hashCode,
      subscriptionOfferDetails.hashCode,
      oneTimePurchaseOfferDetails.hashCode,
      productId.hashCode,
      name.hashCode,
      productType.hashCode,
    );
  }
}

@JsonSerializable()
@immutable
class ProductDetailsResponseWrapper {
  /// Creates a [ProductDetailsResponseWrapper] with the given purchase details.
  @visibleForTesting
  const ProductDetailsResponseWrapper(
      {required this.billingResult, required this.productDetailsList});

  /// Constructs an instance of this from a key value map of data.
  ///
  /// The map needs to have named string keys with values matching the names and
  /// types of all of the members on this class.
  factory ProductDetailsResponseWrapper.fromJson(Map<String, dynamic> map) =>
      _$ProductDetailsResponseWrapperFromJson(map);

  /// The final result of the [BillingClient.querySkuDetails] call.
  final BillingResultWrapper billingResult;

  /// A list of [ProductDetailsWrapper] matching the query to [BillingClient.querySkuDetails].
  @JsonKey(defaultValue: <ProductDetailsWrapper>[])
  final List<ProductDetailsWrapper> productDetailsList;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ProductDetailsResponseWrapper &&
        other.billingResult == billingResult &&
        other.productDetailsList == productDetailsList;
  }

  @override
  int get hashCode => Object.hash(billingResult, productDetailsList);
}

@JsonSerializable()
@immutable
class SubscriptionOfferDetails {
  @visibleForTesting
  const SubscriptionOfferDetails({
    required this.offerTags,
    required this.offerToken,
    required this.pricingPhases,
  });

  factory SubscriptionOfferDetails.fromJson(Map<String, dynamic> map) =>
      _$SubscriptionOfferDetailsFromJson(map);

  final String offerToken;

  @JsonKey(defaultValue: <String>[])
  final List<String> offerTags;

  @JsonKey(defaultValue: <PricingPhase>[])
  final List<PricingPhase> pricingPhases;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SubscriptionOfferDetails &&
        other.offerTags == offerTags &&
        other.pricingPhases == pricingPhases &&
        other.offerToken == offerToken;
  }

  @override
  int get hashCode => Object.hash(offerTags, pricingPhases, offerToken);
}

@JsonSerializable()
@immutable
class OneTimePurchaseOfferDetails {
  @visibleForTesting
  const OneTimePurchaseOfferDetails({
    required this.formattedPrice,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
  });

  factory OneTimePurchaseOfferDetails.fromJson(Map<String, dynamic> map) =>
      _$OneTimePurchaseOfferDetailsFromJson(map);

  final String formattedPrice;
  final int priceAmountMicros;
  final String priceCurrencyCode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is OneTimePurchaseOfferDetails &&
        other.formattedPrice == formattedPrice &&
        other.priceAmountMicros == priceAmountMicros &&
        other.priceCurrencyCode == priceCurrencyCode;
  }

  @override
  int get hashCode => Object.hash(
        formattedPrice,
        priceAmountMicros,
        priceCurrencyCode,
      );
}

@JsonSerializable()
@immutable
class PricingPhase {
  @visibleForTesting
  const PricingPhase({
    required this.billingCycleCount,
    required this.billingPeriod,
    required this.priceAmountMicros,
    required this.priceCurrencyCode,
    required this.formattedPrice,
    required this.recurrenceMode,
  });

  factory PricingPhase.fromJson(Map<String, dynamic> map) =>
      _$PricingPhaseFromJson(map);

  final int billingCycleCount;
  final String billingPeriod;
  final int priceAmountMicros;
  final String priceCurrencyCode;
  final String formattedPrice;
  final String recurrenceMode;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is PricingPhase &&
        other.billingCycleCount == billingCycleCount &&
        other.billingPeriod == billingPeriod &&
        other.priceCurrencyCode == priceCurrencyCode &&
        other.formattedPrice == formattedPrice &&
        other.recurrenceMode == recurrenceMode &&
        other.priceAmountMicros == priceAmountMicros;
  }

  @override
  int get hashCode => Object.hash(
        billingCycleCount,
        billingPeriod,
        priceAmountMicros,
        priceCurrencyCode,
        formattedPrice,
        recurrenceMode,
      );
}
