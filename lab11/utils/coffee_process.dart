class CoffeeProcess {
  static Future<void> heatWater() async {
    print('_start_process: water');
    await Future.delayed(const Duration(seconds: 3));
    print('_done_process: water');
  }

  static Future<void> brewCoffee(String coffeeName) async {
    print('_start_process: $coffeeName');
    await Future.delayed(const Duration(seconds: 5));
    print('_done_process: coffee with water');
  }

  static Future<void> whipMilk() async {
    print('_start_process: milk');
    await Future.delayed(const Duration(seconds: 5));
    print('_done_process: milk');
  }

  static Future<void> mixCoffeeAndMilk(String coffeeName) async {
    print('_start_process: mix');
    await Future.delayed(const Duration(seconds: 3));
    print('_done_process: $coffeeName');
  }

  static Future<void> makeWithoutMilk(String coffeeName) async {
    print('*------------------------------*');
    print('_start_');

    await heatWater();

    print('_then_');

    await brewCoffee(coffeeName);

    print('_end_');
  }

  static Future<void> makeWithMilk(String coffeeName) async {
    print('*------------------------------*');
    print('_start_');

    await Future.wait([heatWater(), whipMilk()]);

    print('_then_');

    await brewCoffee('espresso');
    await mixCoffeeAndMilk(coffeeName);

    print('_end_');
  }
}
