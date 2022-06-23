part of 'locales_bloc.dart';

@immutable
abstract class LocalesEvent extends Equatable {
  const LocalesEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class LoadLocals extends LocalesEvent {}

class FilterLocales extends LocalesEvent {}

class SetLanguageIdFilter extends LocalesEvent {
  final String languageId;
  const SetLanguageIdFilter(this.languageId);
  @override
  List<Object> get props => [languageId];
}

class SetByModuleIdFilter extends LocalesEvent {
  final String moduleId;
  const SetByModuleIdFilter(this.moduleId);
  @override
  List<Object> get props => [moduleId];
}

class SetValueFilter extends LocalesEvent {
  final String value;
  const SetValueFilter(this.value);
  @override
  List<Object> get props => [value];
}
