import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pixlog_test/repositories/locale_repository.dart';

import '../models/locale.dart';

part 'locales_event.dart';
part 'locales_state.dart';

class LocalesBloc extends Bloc<LocalesEvent, LocalesState> {
  final _repo = GetIt.I.get<LocaleRepository>();
  String _languageId = '';
  String _moduleId = '';
  String _value = '';
  LocalesBloc() : super(LoadingLocales()) {
    on<LoadLocals>((event, emit) async {
      var list = await _repo.getAll();
      emit(LocalesLoaded(locales: list));
    });
    on<FilterLocales>(((event, emit) async {
      emit(LoadingLocales());
      var list = await _repo.getAll();
      if (_languageId.isNotEmpty) {
        list.removeWhere((locale) => locale.languageId != _languageId);
      }
      if (_moduleId.isNotEmpty) {
        list.removeWhere((locale) => locale.moduleId != _moduleId);
      }
      if (_value.isNotEmpty) {
        list.removeWhere((locale) => !locale.value.contains(_value));
      }
      emit(LocalesLoaded(locales: list));
    }));
    on<SetLanguageIdFilter>((event, emit) async {
      _languageId = event.languageId;
    });
    on<SetByModuleIdFilter>((event, emit) async {
      _moduleId = event.moduleId;
    });
    on<SetValueFilter>((event, emit) async {
      _value = event.value;
    });
  }
}
