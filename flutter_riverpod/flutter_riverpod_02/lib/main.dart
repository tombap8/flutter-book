import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_02/fruit_store.dart';

void main() {
  // 1. Riverpod을 사용하기 위해 ProviderScope로 MyApp을 설정해줍니다.
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FruitPage(),
    );
  }
}

// 2. 위젯을 ConsumerWidget으로 만들면 Provider에 접근할 수 있습니다.
class FruitPage extends ConsumerWidget {
  const FruitPage({super.key});

  // 3. ConsumerWidget 클래스의 build 메서드는 WidgetRef를 참조할 수 있습니다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 4. ref를 통해 Provider가 관리하는 상태(데이터)에 접근할 수 있습니다.
    // 5. ref.watch()는 상태값이 변경되는 것을 계속 수신할 때 사용합니다.
    // 6.StateNotifierProvider는 상태 변경이 가능하기 때문에 watch()로 수신합니다.
    String data = ref.watch(fruitProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "data : $data",
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              onPressed: () {
                // 7. ref.read() 메서드로 상태값이 아닌 FruitStore(창고)에 접근할 수 있다.
                FruitStore fruitStore = ref.read(fruitProvider.notifier);
                fruitStore.changeData();
              },
              child: Text("딸기로 상태 변경"),
            ),
          ],
        ),
      ),
    );
  }
}
