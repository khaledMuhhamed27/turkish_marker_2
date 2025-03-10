import 'package:equatable/equatable.dart';

// جعل UpdateUserState هو abstract class بدلاً من sealed class
abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

// الحالة الابتدائية
class UpdateUserInitial extends UpdateUserState {}

// حالة التحميل
class UpdateUserLoading extends UpdateUserState {}

// حالة البيانات المحملة بنجاح
class UpdateUserLoaded extends UpdateUserState {
  final Map<String, dynamic> user;

  const UpdateUserLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

// حالة التحديث الناجح
class UserUpdated extends UpdateUserState {
  final Map<String, dynamic> updatedUser;

  const UserUpdated({required this.updatedUser});

  @override
  List<Object?> get props => [updatedUser];
}

// حالة الخطأ
class UpdateUserError extends UpdateUserState {
  final String message;

  const UpdateUserError({required this.message});

  @override
  List<Object?> get props => [message];
}
