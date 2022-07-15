// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.inapppurchase;

import android.util.Log;

import androidx.annotation.Nullable;

import com.android.billingclient.api.AccountIdentifiers;
import com.android.billingclient.api.BillingResult;
import com.android.billingclient.api.ProductDetails;
import com.android.billingclient.api.Purchase;
import com.android.billingclient.api.PurchaseHistoryRecord;
import com.android.billingclient.api.SkuDetails;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Currency;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

/** Handles serialization of {@link com.android.billingclient.api.BillingClient} related objects. */
/*package*/ class Translator {
  static HashMap<String, Object> fromSkuDetail(SkuDetails detail) {
    HashMap<String, Object> info = new HashMap<>();
    info.put("title", detail.getTitle());
    info.put("description", detail.getDescription());
    info.put("freeTrialPeriod", detail.getFreeTrialPeriod());
    info.put("introductoryPrice", detail.getIntroductoryPrice());
    info.put("introductoryPriceAmountMicros", detail.getIntroductoryPriceAmountMicros());
    info.put("introductoryPriceCycles", detail.getIntroductoryPriceCycles());
    info.put("introductoryPricePeriod", detail.getIntroductoryPricePeriod());
    info.put("price", detail.getPrice());
    info.put("priceAmountMicros", detail.getPriceAmountMicros());
    info.put("priceCurrencyCode", detail.getPriceCurrencyCode());
    info.put("priceCurrencySymbol", currencySymbolFromCode(detail.getPriceCurrencyCode()));
    info.put("sku", detail.getSku());
    info.put("type", detail.getType());
    info.put("subscriptionPeriod", detail.getSubscriptionPeriod());
    info.put("originalPrice", detail.getOriginalPrice());
    info.put("originalPriceAmountMicros", detail.getOriginalPriceAmountMicros());
    return info;
  }

  static HashMap<String, Object> fromProductDetail(ProductDetails detail) {
    HashMap<String, Object> info = new HashMap<>();

    info.put("title", detail.getTitle());
    info.put("description", detail.getDescription());
    info.put("subscriptionOfferDetails", fromSubscriptionOfferDetailsList(detail.getSubscriptionOfferDetails()));

    final ProductDetails.OneTimePurchaseOfferDetails otpDetails = detail.getOneTimePurchaseOfferDetails();
    if (otpDetails != null) {
      info.put("oneTimePurchaseOfferDetails", fromOneTimePurchaseOfferDetails(otpDetails));
    }

    info.put("productId", detail.getProductId());
    info.put("name", detail.getName());
    info.put("productType", detail.getProductType());

    return info;
  }

  static HashMap<String, Object> fromOneTimePurchaseOfferDetails(
      ProductDetails.OneTimePurchaseOfferDetails details) {
    HashMap<String, Object> info = new HashMap<>();

    info.put("formattedPrice", details.getFormattedPrice());
    info.put("priceAmountMicros", details.getPriceAmountMicros());
    info.put("priceCurrencyCode", details.getPriceCurrencyCode());

    return info;
  }

  static List<HashMap<String, Object>> fromSubscriptionOfferDetailsList(
         @Nullable List<ProductDetails.SubscriptionOfferDetails> subscriptionOfferDetailsList) {
    if (subscriptionOfferDetailsList == null) {
      return Collections.emptyList();
    }

    ArrayList<HashMap<String, Object>> output = new ArrayList<>();

    for(ProductDetails.SubscriptionOfferDetails offerDetails: subscriptionOfferDetailsList) {
      output.add(fromSubscriptionOfferDetails(offerDetails));
    }

    return output;
  }

  static HashMap<String, Object> fromSubscriptionOfferDetails(
          ProductDetails.SubscriptionOfferDetails offerDetails) {
    HashMap<String, Object> info = new HashMap<>();

    info.put("offerTags",offerDetails.getOfferTags());
    info.put("offerToken", offerDetails.getOfferToken());
    info.put("pricingPhases", fromPricingPhasesList(offerDetails.getPricingPhases().getPricingPhaseList()));

    return info;
  }

  static List<HashMap<String, Object>> fromPricingPhasesList(
          List<ProductDetails.PricingPhase> pricingPhasesList) {
    ArrayList<HashMap<String, Object>> output = new ArrayList<>();

    Log.d("TAG", "fromPricingPhasesList: " + pricingPhasesList.toString());

    for(ProductDetails.PricingPhase phase: pricingPhasesList) {
      output.add(fromPricingPhase(phase));
    }

    return output;
  }

  static HashMap<String, Object> fromPricingPhase(ProductDetails.PricingPhase pricingPhase) {
    HashMap<String, Object> info = new HashMap<>();

    info.put("billingCycleCount", pricingPhase.getBillingCycleCount());
    info.put("billingPeriod", pricingPhase.getBillingPeriod());
    info.put("priceAmountMicros", pricingPhase.getPriceAmountMicros());
    info.put("priceCurrencyCode", pricingPhase.getPriceCurrencyCode());
    info.put("formattedPrice", pricingPhase.getFormattedPrice());
    info.put("recurrenceMode", pricingPhase.getRecurrenceMode());

    return info;
  }

  static List<HashMap<String, Object>> fromProductDetailsList(
      @Nullable List<ProductDetails> productDetailsList) {
    if (productDetailsList == null) {
      return Collections.emptyList();
    }

    ArrayList<HashMap<String, Object>> output = new ArrayList<>();
    for (ProductDetails detail : productDetailsList) {
      output.add(fromProductDetail(detail));
    }
    return output;
  }

  static List<HashMap<String, Object>> fromSkuDetailsList(
      @Nullable List<SkuDetails> skuDetailsList) {
    if (skuDetailsList == null) {
      return Collections.emptyList();
    }

    ArrayList<HashMap<String, Object>> output = new ArrayList<>();
    for (SkuDetails detail : skuDetailsList) {
      output.add(fromSkuDetail(detail));
    }
    return output;
  }

  static HashMap<String, Object> fromPurchase(Purchase purchase) {
    HashMap<String, Object> info = new HashMap<>();
    List<String> skus = purchase.getSkus();
    info.put("orderId", purchase.getOrderId());
    info.put("packageName", purchase.getPackageName());
    info.put("purchaseTime", purchase.getPurchaseTime());
    info.put("purchaseToken", purchase.getPurchaseToken());
    info.put("signature", purchase.getSignature());
    info.put("skus", skus);
    info.put("products", purchase.getProducts());
    info.put("isAutoRenewing", purchase.isAutoRenewing());
    info.put("originalJson", purchase.getOriginalJson());
    info.put("developerPayload", purchase.getDeveloperPayload());
    info.put("isAcknowledged", purchase.isAcknowledged());
    info.put("purchaseState", purchase.getPurchaseState());
    info.put("quantity", purchase.getQuantity());
    AccountIdentifiers accountIdentifiers = purchase.getAccountIdentifiers();
    if (accountIdentifiers != null) {
      info.put("obfuscatedAccountId", accountIdentifiers.getObfuscatedAccountId());
      info.put("obfuscatedProfileId", accountIdentifiers.getObfuscatedProfileId());
    }
    return info;
  }

  static HashMap<String, Object> fromPurchaseHistoryRecord(
      PurchaseHistoryRecord purchaseHistoryRecord) {
    HashMap<String, Object> info = new HashMap<>();
    List<String> skus = purchaseHistoryRecord.getSkus();
    info.put("purchaseTime", purchaseHistoryRecord.getPurchaseTime());
    info.put("purchaseToken", purchaseHistoryRecord.getPurchaseToken());
    info.put("signature", purchaseHistoryRecord.getSignature());
    info.put("skus", skus);
    info.put("developerPayload", purchaseHistoryRecord.getDeveloperPayload());
    info.put("originalJson", purchaseHistoryRecord.getOriginalJson());
    info.put("quantity", purchaseHistoryRecord.getQuantity());
    return info;
  }

  static List<HashMap<String, Object>> fromPurchasesList(@Nullable List<Purchase> purchases) {
    if (purchases == null) {
      return Collections.emptyList();
    }

    List<HashMap<String, Object>> serialized = new ArrayList<>();
    for (Purchase purchase : purchases) {
      serialized.add(fromPurchase(purchase));
    }
    return serialized;
  }

  static List<HashMap<String, Object>> fromPurchaseHistoryRecordList(
      @Nullable List<PurchaseHistoryRecord> purchaseHistoryRecords) {
    if (purchaseHistoryRecords == null) {
      return Collections.emptyList();
    }

    List<HashMap<String, Object>> serialized = new ArrayList<>();
    for (PurchaseHistoryRecord purchaseHistoryRecord : purchaseHistoryRecords) {
      serialized.add(fromPurchaseHistoryRecord(purchaseHistoryRecord));
    }
    return serialized;
  }

  static HashMap<String, Object> fromBillingResult(BillingResult billingResult) {
    HashMap<String, Object> info = new HashMap<>();
    info.put("responseCode", billingResult.getResponseCode());
    info.put("debugMessage", billingResult.getDebugMessage());
    return info;
  }

  /**
   * Gets the symbol of for the given currency code for the default {@link Locale.Category#DISPLAY
   * DISPLAY} locale. For example, for the US Dollar, the symbol is "$" if the default locale is the
   * US, while for other locales it may be "US$". If no symbol can be determined, the ISO 4217
   * currency code is returned.
   *
   * @param currencyCode the ISO 4217 code of the currency
   * @return the symbol of this currency code for the default {@link Locale.Category#DISPLAY
   *     DISPLAY} locale
   * @exception NullPointerException if <code>currencyCode</code> is null
   * @exception IllegalArgumentException if <code>currencyCode</code> is not a supported ISO 4217
   *     code.
   */
  static String currencySymbolFromCode(String currencyCode) {
    return Currency.getInstance(currencyCode).getSymbol();
  }
}
