import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:vernon_cms_ui/core/errors/failures.dart';
import 'package:vernon_cms_ui/features/auth/domain/entities/auth_token.dart';
import 'package:vernon_cms_ui/features/auth/domain/entities/login_params.dart';
import 'package:vernon_cms_ui/features/auth/domain/usecases/get_remembered_username_usecase.dart';
import 'package:vernon_cms_ui/features/auth/domain/usecases/login_usecase.dart';
import 'package:vernon_cms_ui/features/auth/presentation/cubit/login_cubit.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockGetRememberedUsernameUseCase extends Mock
    implements GetRememberedUsernameUseCase {}

class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late LoginCubit cubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockGetRememberedUsernameUseCase mockGetRememberedUsername;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockGetRememberedUsername = MockGetRememberedUsernameUseCase();
    cubit = LoginCubit(
      loginUseCase: mockLoginUseCase,
      getRememberedUsernameUseCase: mockGetRememberedUsername,
    );
  });

  tearDown(() => cubit.close());

  const tToken = AuthToken(
    accessToken: 'access_123',
    refreshToken: 'refresh_123',
    expiresIn: 3600,
  );

  group('LoginCubit', () {
    test('initial state should be LoginState.initial()', () {
      expect(cubit.state, const LoginState.initial());
    });

    group('login', () {
      blocTest<LoginCubit, LoginState>(
        'emits [loading, success] when login berhasil',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => const Right(tToken));
          return cubit;
        },
        act: (cubit) => cubit.login(
          username: 'admin',
          password: 'password',
          rememberMe: false,
        ),
        expect: () => [
          const LoginState.loading(),
          const LoginState.success(),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'emits [loading, error] when login gagal',
        build: () {
          when(() => mockLoginUseCase(any())).thenAnswer(
            (_) async => const Left(
              ServerFailure('Username atau password salah', statusCode: 401),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.login(
          username: 'admin',
          password: 'wrong',
          rememberMe: false,
        ),
        expect: () => [
          const LoginState.loading(),
          const LoginState.error('Username atau password salah'),
        ],
      );
    });

    group('loadRememberedUsername', () {
      blocTest<LoginCubit, LoginState>(
        'emits initial with username when remembered username ada',
        build: () {
          when(() => mockGetRememberedUsername())
              .thenAnswer((_) async => const Right('admin'));
          return cubit;
        },
        act: (cubit) => cubit.loadRememberedUsername(),
        expect: () => [
          const LoginState.initial(
            rememberedUsername: 'admin',
            rememberMe: true,
          ),
        ],
      );

      blocTest<LoginCubit, LoginState>(
        'tidak emit state baru when remembered username kosong',
        build: () {
          when(() => mockGetRememberedUsername())
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.loadRememberedUsername(),
        expect: () => <LoginState>[],
      );
    });
  });
}
