import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터
String data = "사과";

// 2. FruitStore는 창고이고, String은 창고 데이터 타입이다.
final fruitProvider = StateNotifierProvider<FruitStore, String>((ref) {
  // 3. 창고에 사과를 전달하고, 그 객체를 adminProvider 즉, 창고관리자가 관리한다.
  return FruitStore(data);
});

// 4. 창고
class FruitStore extends StateNotifier<String> {
  // 5. super.state는 전달 받은 사과를 data를 상태로 등록하는 코드이다.
  FruitStore(super.state);

  // 6. 창고가 관리하는 데이터를 변경하는 메서드이다.
  void changeData() {
    state = "딸기";
  }
}
