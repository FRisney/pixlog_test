import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pixlog_test/repositories/locale_repository.dart';

import 'bloc/locales_bloc.dart';
import 'screens/main_list.dart';

Future<void> main() async {
  GetIt.I.registerSingleton<LocaleRepository>(
    (kDebugMode) ? MockLocaleRepository() : ProductionLocaleRepository(),
  );
  await GetIt.I.allReady();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalesBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        title: 'Material App',
        home: const ListScreen(),
      ),
    );
  }
}
