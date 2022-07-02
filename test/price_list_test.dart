import 'package:flutter_test/flutter_test.dart';
import 'package:stock_market/pages/stock_detail_page.dart';

main() {
  test("It should check if list contains any price value", () {
    StockDetailPage()
        .checkIfStringContainsPriceData("hey it is \$20 nice to meet \$50 you");

    expect([3, 7], [3, 7]);

    StockDetailPage()
        .checkIfStringContainsPriceData("hey it is nice to meet you");

    expect(["hey", "it", "is", "nice", "to", "meet", "you"],
        ["hey", "it", "is", "nice", "to", "meet", "you"]);
  });

  test("Manipulate list of string with price in it", () {
    StockDetailPage().manipulateString("hey it is \$20 nice to meet \$50 you");

    expect(["hey", "it", "is", "(\$20)", "nice", "to", "meet", "(\$50)", "you"],
        ["hey", "it", "is", "(\$20)", "nice", "to", "meet", "(\$50)", "you"]);
  });
}
