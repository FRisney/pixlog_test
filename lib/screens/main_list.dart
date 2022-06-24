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
          Card(
            elevation: 15,
            surfaceTintColor: Colors.grey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      filterField(
                          (languageId) =>
                              read.add(SetLanguageIdFilter(languageId)),
                          'LanguageId Filter'),
                      filterField(
                          (moduleId) => read.add(SetByModuleIdFilter(moduleId)),
                          'ModuleId Filter'),
                      filterField((value) => read.add(SetValueFilter(value)),
                          'Value Filter'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.grey,
                      elevation: 5,
                      primary: Colors.blue,
                    ),
                    onPressed: () => read.add(FilterLocales()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 25),
                      child: Text(
                        'Filtrar',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget filterField(
      void Function(String languageId) onChange, String placeholder) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: TextField(
        decoration: InputDecoration(
          labelText: placeholder,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        ),
        onChanged: onChange,
      ),
    );
  }
}
