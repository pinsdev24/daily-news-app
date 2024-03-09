import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_learn/core/errors/failures.dart';
import 'package:riverpod_learn/features/authentication/domain/entities/sign_up_entity.dart';
import '../repositories/authentication_repository.dart';

class SignUpUseCase {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, UserCredential>> call(SignUpEntity signup) async {
    return await repository.signUp(signup);
  }
}
