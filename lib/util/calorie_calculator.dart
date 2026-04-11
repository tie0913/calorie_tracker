class CalorieCalculator {
  static double calculateTDEE(
    double weight,
    double height,
    int age, {
    double activityLevel = 1.2,
  }) {
    final bmr = 10 * weight + 6.25 * height - 5 * age - 80;
    return bmr * activityLevel;
  }
}