import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  // 1. Todo 객체
  final bool isCompleted;
  final String description;
  Todo(this.isCompleted, this.description);
}

// 2. Provider 생성 (provider는 Todo() 데이터를 관리합니다)
final todoProvider = Provider<Todo>((ref) {
  return Todo(true, "공부하기");
});
