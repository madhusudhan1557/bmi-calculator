class BodyFatCalculator {
  int age;
  double bmi;
  double? bf;

  BodyFatCalculator({
    required this.age,
    required this.bmi,
  });

  double bfcalulator() {
    bf = (1.20 * bmi) + (0.23 * age) - 16.2;
    return bf!;
  }

  String result() {
    if (bf! > 100) {
      return "Error";
    }
    if (bf!.isNegative) {
      return "Body Fat cant be Negative";
    } else {
      return "Your Body Fat Percentage is " + bf!.toStringAsFixed(1);
    }
  }

  String result2() {
    if (bf! >= 100) {
      return "Error";
    }
    if (bf!.isNegative) {
      return "You might have given invalid values, Body Fat Cant be Negative";
    } else if (bf! <= 8) {
      return "You have much lower body fat take a good care or consult your doctor";
    } else if (bf! >= 30) {
      return "You have higher body fat please take a good care or consult your doctor";
    } else {
      return "You are quite healthy take care and stay healthy";
    }
  }
}
