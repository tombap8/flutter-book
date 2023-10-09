import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/data/dtos/response_dto.dart';
import 'package:flutter_blog/data/dtos/user_request.dart';
import 'package:flutter_blog/data/models/user.dart';
import 'package:flutter_blog/data/providers/session_provider.dart';
import 'package:flutter_blog/data/repositories/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final userProvider = Provider<UserProvider>((ref) {
  return UserProvider(ref);
});

class UserProvider {
  final mContext = navigatorKey.currentContext;
  final Ref ref;

  User? user;

  UserProvider(this.ref);

  // 회원 가입
  Future<void> join(JoinReqDTO reqDTO) async {
    Logger().d("join");

    // 1. Repository 메소드를 호출하여 응답 결과 및 데이터 받음.
    ResponseDTO responseDTO = await UserRepository().fetchJoin(reqDTO);

    // 응답 결과 값이 1일 경우
    if (responseDTO.code == 1) {
      // 2. 페이지 이동
      Navigator.pushNamed(mContext!, Move.loginPage);
    } else {
      // 실패 시 스낵바
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("회원가입 실패")));
    }
  }

  // 로그인
  Future<void> login(LoginReqDTO loginReqDTO) async {
    Logger().d("login");

    // 1. Repository 메소드를 호출하여 응답 결과 및 데이터 받음.
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);

    // 응답 결과 값이 1일 경우
    if (responseDTO.code == 1) {
      // 2. 토큰을 휴대폰에 저장
      await secureStorage.write(key: "jwt", value: responseDTO.token);

      // 3. 로그인 상태 등록
      ref.read(sessionProvider).loginSuccess(responseDTO.data, responseDTO.token!);

      // 4. 페이지 이동
      Navigator.popAndPushNamed(mContext!, Move.postListPage);
    } else {
      // 실패 시 스낵바
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("로그인 실패 : ${responseDTO.msg}")));
    }
  }

  // 로그아웃
  void logout() {
    ref.read(sessionProvider).logoutSuccess();
  }
}
