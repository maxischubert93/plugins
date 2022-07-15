// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsWrapper _$ProductDetailsWrapperFromJson(Map json) =>
    ProductDetailsWrapper(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      subscriptionOfferDetails:
          (json['subscriptionOfferDetails'] as List<dynamic>?)
                  ?.map((e) => SubscriptionOfferDetails.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList() ??
              [],
      oneTimePurchaseOfferDetails: json['oneTimePurchaseOfferDetails'] == null
          ? null
          : OneTimePurchaseOfferDetails.fromJson(Map<String, dynamic>.from(
              json['oneTimePurchaseOfferDetails'] as Map)),
      productId: json['productId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      productType: json['productType'] as String? ?? '',
    );

ProductDetailsResponseWrapper _$ProductDetailsResponseWrapperFromJson(
        Map json) =>
    ProductDetailsResponseWrapper(
      billingResult:
          BillingResultWrapper.fromJson((json['billingResult'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      )),
      productDetailsList: (json['productDetails'] as List<dynamic>?)
              ?.map((e) => ProductDetailsWrapper.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );

SubscriptionOfferDetails _$SubscriptionOfferDetailsFromJson(Map json) =>
    SubscriptionOfferDetails(
      offerTags: (json['offerTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      offerToken: json['offerToken'] as String,
      pricingPhases: (json['pricingPhases'] as List<dynamic>?)
              ?.map((e) =>
                  PricingPhase.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          [],
    );

OneTimePurchaseOfferDetails _$OneTimePurchaseOfferDetailsFromJson(Map json) =>
    OneTimePurchaseOfferDetails(
      formattedPrice: json['formattedPrice'] as String,
      priceAmountMicros: json['priceAmountMicros'] as int,
      priceCurrencyCode: json['priceCurrencyCode'] as String,
    );

PricingPhase _$PricingPhaseFromJson(Map json) => PricingPhase(
      billingCycleCount: json['billingCycleCount'] as int,
      billingPeriod: json['billingPeriod'] as String,
      priceAmountMicros: json['priceAmountMicros'] as int,
      priceCurrencyCode: json['priceCurrencyCode'] as String,
      formattedPrice: json['formattedPrice'] as String,
      recurrenceMode: json['recurrenceMode'] as int,
    );
