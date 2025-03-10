import 'package:equatable/equatable.dart';

// جعل الفئة Abstract بدلاً من Sealed
abstract class UpdateUserEvent1 extends Equatable {
  const UpdateUserEvent1();

  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends UpdateUserEvent1 {
  final String name;
  final String email;
  final String mobile;
  final String token;

  const UpdateUserEvent({
    required this.name,
    required this.email,
    required this.mobile,
    required this.token,
  });

  @override
  List<Object?> get props => [name, email, mobile, token];
}
