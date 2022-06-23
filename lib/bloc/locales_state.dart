part of 'locales_bloc.dart';

@immutable
abstract class LocalesState extends Equatable {
  const LocalesState();
  @override
  List<Object> get props => [];
}

class LoadingLocales extends LocalesState {}

class LocalesLoaded extends LocalesState {
  final List<Locale> locales;

  const LocalesLoaded({
    required this.locales,
  });
  @override
  List<Object> get props => locales;
}
