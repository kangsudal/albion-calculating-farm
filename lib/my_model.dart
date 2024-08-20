import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  //input
  double farmland = 0; //경작지
  double seedProfitRateNoWater = 0; //단일 씨앗 수확률(비관수)
  double seedProfitRateWater = 0; //단일 씨앗 수확률(관수)
  double singleCropYieldAverage = 0; //단일 작물 수확량 평균
  double waterAmount = 0; //관수 사용량
  double cropsSellingPrice = 0; //작물 판매가
  double seedBuyingPrice = 0; //씨앗구매가
  double taxRevenue = 0; //세금시 수익(프미했을때 세금으로 얼마가 때지냐)

  //output
  double seedYield = 0; //씨앗 수확량
  double corpYield = 0; //작물 수확량
  double dailyPureEarnings = 0; //세금 일당 순수익
  double numOfNeededSeedMore = 0; //추가 필요 씨앗 개수

  void setValues() {
    //mid calculating value
    double waterSeedProfitRate =
        seedProfitRateNoWater + seedProfitRateWater; //관수 씨앗 수확률
    double totalNumberOfSeedsPlanted = farmland * 9; //총 씨앗 심어야하는 개수
    double noTaxDailyEarnings = cropsSellingPrice * corpYield; //논세금 일당 수익
    // print('논세금 일당수익:$noTaxDailyEarnings');
    // print('작물 판매가: $cropsSellingPrice');
    // print('작물 수확량: $corpYield');
    // print('세금시 수익: $taxRevenue');
    double dailyEarnings = 0; //일당 수익
    double priceOfNeededSeedMore = 0; //추가 필요 씨앗 금액

    dailyEarnings = noTaxDailyEarnings * taxRevenue;

    //output
    seedYield = waterAmount * waterSeedProfitRate +
        (totalNumberOfSeedsPlanted - waterAmount) * seedProfitRateNoWater;
    corpYield = totalNumberOfSeedsPlanted * singleCropYieldAverage;

    if (totalNumberOfSeedsPlanted - seedYield > 0) {
      numOfNeededSeedMore = totalNumberOfSeedsPlanted - seedYield;
    } else {
      numOfNeededSeedMore = 0;
    }
    priceOfNeededSeedMore = numOfNeededSeedMore * seedBuyingPrice;
    print("추가 필요 씨앗 개수: $numOfNeededSeedMore");
    print("추가 필요 씨앗 금액: $priceOfNeededSeedMore");
    dailyPureEarnings = dailyEarnings - priceOfNeededSeedMore;
    print("일당 수익: $dailyEarnings");
    print("추가 필요 씨앗 금액: $priceOfNeededSeedMore");
    notifyListeners();
  }

  void resetValues() {
    farmland = 0;
    seedProfitRateNoWater = 0;
    seedProfitRateWater = 0;
    singleCropYieldAverage = 0;
    waterAmount = 0;
    cropsSellingPrice = 0;
    seedBuyingPrice = 0;
    taxRevenue = 0;
    seedYield = 0;
    corpYield = 0;
    dailyPureEarnings = 0;

    notifyListeners();
  }
}
