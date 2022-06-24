import 'dart:convert';
import 'dart:developer' as dev;

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../models/locale.dart';

abstract class LocaleRepository {
  Future<List<Locale>> getAll();
}

class ProductionLocaleRepository implements LocaleRepository {
  final LocalStorage storage = LocalStorage('cached_locales');
  @override
  Future<List<Locale>> getAll() async {
    late List data;
    await storage.ready;
    var dateCached = storage.getItem('timestamp');
    if (dateCached == null) {
      data = await _getFromApi();
    } else if (DateTime.fromMillisecondsSinceEpoch(dateCached)
            .difference(DateTime.now())
            .inMinutes >
        5) {
      data = await _getFromApi();
    } else {
      data = storage.getItem('data');
    }
    return data.map((e) {
      if (e['updated_at'] == null) {
        e['updated_at'] = '1970-01-01T00:00:01Z';
      }
      if (e['created_at'] == null) {
        e['created_at'] = '1970-01-01T00:00:01Z';
      }
      return Locale.fromJson(e);
    }).toList();
  }

  Future<List> _getFromApi() async {
    List list = [];
    var resp = await http.get(
      Uri.parse('http://portal.greenmilesoftware.com/get_resources_since'),
    );
    if (resp.statusCode == 200) {
      var decoded = jsonDecode(resp.body);
      list = decoded.map((e) => e['resource']).toList();
      storage.setItem('timestamp', DateTime.now().millisecondsSinceEpoch);
      storage.setItem('data', list);
    }
    return list;
  }
}

class MockLocaleRepository implements LocaleRepository {
  @override
  Future<List<Locale>> getAll() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Locale.fromJson({
        "created_at": "2021-08-14T20:49:32Z",
        "updated_at": "2021-08-14T20:49:32Z",
        "resource_id": "textfile.combineOrders",
        "module_id": "GreenMileTrack",
        "value": "Merge orders in the same stop",
        "language_id": "en-g",
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:36Z",
        "updated_at": "2021-01-19T13:12:36Z",
        "resource_id": "Survey.Question.Operation.fields",
        "module_id": "GreenMileTrack",
        "value": "Arithmetische Operation",
        "language_id": "de"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:38Z",
        "updated_at": "2021-01-19T13:12:38Z",
        "resource_id": "Survey.Operation.haveFieldsEmpty",
        "module_id": "GreenMileTrack",
        "value":
            "Completare tutti i campi per una domanda su un'operazione aritmetica",
        "language_id": "it"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:39Z",
        "updated_at": "2021-01-19T13:12:39Z",
        "resource_id": "Survey.Question.Operation.additon",
        "module_id": "GreenMileTrack",
        "value": "Somme",
        "language_id": "fr"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:39Z",
        "updated_at": "2021-01-19T13:12:39Z",
        "resource_id": "Survey.Question.Operation.additon",
        "module_id": "GreenMileTrack",
        "value": "การเพิ่ม",
        "language_id": "th"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:40Z",
        "updated_at": "2021-01-19T13:12:40Z",
        "resource_id": "Survey.Question.Operation.subtraction",
        "module_id": "GreenMileTrack",
        "value": "Sustracción",
        "language_id": "es"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:42Z",
        "updated_at": "2021-01-19T13:12:42Z",
        "resource_id": "Survey.Question.Operation.multiplication",
        "module_id": "GreenMileTrack",
        "value": "การคูณ",
        "language_id": "th"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:43Z",
        "updated_at": "2021-01-19T13:12:43Z",
        "resource_id": "Survey.Question.Operation.division",
        "module_id": "GreenMileTrack",
        "value": "แผนก",
        "language_id": "th"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:44Z",
        "updated_at": "2021-01-19T13:12:44Z",
        "resource_id": "Greenmile.Grid.Button.deleteSelected",
        "module_id": "GreenMileTrack",
        "value": "Seleccione al menos un elemento para eliminar",
        "language_id": "es"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:45Z",
        "updated_at": "2021-01-19T13:12:45Z",
        "resource_id": "users.changePasswordHeader.label",
        "module_id": "GreenMileTrack",
        "value": "รีเซ็ตรหัสผ่านของคุณ",
        "language_id": "th"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:48Z",
        "updated_at": "2021-01-19T13:12:48Z",
        "resource_id": "Greenmile.Grid.Button.helpPage",
        "module_id": "GreenMileTrack",
        "value": "Ayuda",
        "language_id": "es"
      }),
      Locale.fromJson({
        "created_at": "2021-01-19T13:12:49Z",
        "updated_at": "2021-01-19T13:12:49Z",
        "resource_id": "survey.operation.orderException",
        "module_id": "GreenMileTrack",
        "value":
            "Non è possibile utilizzare operandi con un ordine uguale o maggiore di quello dell'operazione che si sta creando",
        "language_id": "it"
      }),
      Locale.fromJson({
        "created_at": "2021-06-17T16:16:16Z",
        "updated_at": "2021-06-17T16:16:16Z",
        "resource_id": "whatsnew",
        "module_id": "GreenMileTrack",
        "value": "What's New",
        "language_id": "en"
      }),
      Locale.fromJson({
        "created_at": "2021-06-17T16:21:38Z",
        "updated_at": "2021-06-17T16:21:38Z",
        "resource_id": "users.createpass",
        "module_id": "GreenMileTrack",
        "value": "Create password",
        "language_id": "en"
      }),
      Locale.fromJson({
        "created_at": "2021-08-14T20:49:26Z",
        "updated_at": "2021-08-14T20:49:26Z",
        "resource_id": "driver.time.day",
        "module_id": "GreenMileDriver",
        "value": "day",
        "language_id": "en-g"
      }),
      Locale.fromJson({
        "created_at": "2021-08-14T20:49:26Z",
        "updated_at": "2021-08-14T20:49:26Z",
        "resource_id": "equipment.button.edit",
        "module_id": "GreenMileTrack",
        "value": "Save",
        "language_id": "en-g"
      }),
      Locale.fromJson({
        "created_at": "2021-08-14T20:49:26Z",
        "updated_at": "2021-08-14T20:49:26Z",
        "resource_id": "pod.photo.comment",
        "module_id": "GreenMileDriverGeneric",
        "value": "Picture comments",
        "language_id": "en-g"
      }),
      Locale.fromJson({
        "created_at": "2021-08-14T20:49:26Z",
        "updated_at": "2021-08-14T20:49:26Z",
        "resource_id": "TextFile.route.stops.stopType.key",
        "module_id": "GreenMileTrack",
        "value": "Stop type key",
        "language_id": "en-g"
      }),
      Locale.fromJson({
        "created_at": "2021-08-14T20:49:27Z",
        "updated_at": "2021-08-14T20:49:27Z",
        "resource_id": "TextFile.route.lastStopIsDestination",
        "module_id": "GreenMileTrack",
        "value": "Last Stop is Destination",
        "language_id": "en-g"
      }),
    ];
  }
}
