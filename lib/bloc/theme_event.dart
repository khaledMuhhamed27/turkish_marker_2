part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentThemeEvent extends ThemeEvent {}



class ThemeChangedEvent extends ThemeEvent {
  final AppTheme setTheme;

  const ThemeChangedEvent({required this.setTheme});
  @override
  List<Object> get props => [setTheme];
}
