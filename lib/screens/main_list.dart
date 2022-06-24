import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/locales_bloc.dart';
import '../components/locale_card.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) context.read<LocalesBloc>().add(LoadLocals());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<LocalesBloc>();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<LocalesBloc, LocalesState>(
              builder: (context, state) {
                if (state is LoadingLocales) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LocalesLoaded) {
                  return ListView.builder(
                    itemCount: state.locales.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LocaleCard(locale: state.locales.elementAt(index));
                    },
                  );
                }
                return const Center(
                  child: Text('Ops! algo de errado nao esta certo'),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (languageId) =>
                          read.add(SetLanguageIdFilter(languageId)),
                    ),
                    TextField(
                      onChanged: (moduleId) {
                        return read.add(SetByModuleIdFilter(moduleId));
                      },
                    ),
                    TextField(
                      onChanged: (value) => read.add(SetValueFilter(value)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    read.add(FilterLocales());
                  },
                  child: const Text('Filtrar')),
            ],
          )
        ],
      ),
    );
  }
}
