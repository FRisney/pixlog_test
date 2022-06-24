import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/locale.dart';

class LocaleCard extends StatelessWidget {
  const LocaleCard({Key? key, required this.locale}) : super(key: key);
  final Locale locale;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      elevation: 6,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              locale.resourceId,
              style: textStyle.titleMedium,
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: textStyle.bodyMedium!.copyWith(color: Colors.black54),
                children: [
                  const TextSpan(text: 'Atualizado em '),
                  TextSpan(
                    style:
                        textStyle.titleSmall!.copyWith(color: Colors.black54),
                    text: DateFormat('dd/MM/yyyy').format(locale.updatedAt),
                  )
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(locale.value),
          ],
        ),
      ),
    );
    return ListTile(
      leading: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DateFormat('dd/MM/yyyy').format(locale.updatedAt)),
          Text(locale.resourceId),
        ],
      ),
      title: Text(locale.value),
    );
  }
}
