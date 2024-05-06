import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ChooseBloc extends BlocBase {

  final _date = BehaviorSubject<String>();
  final _local = BehaviorSubject<String>();
  final _info = BehaviorSubject<Map<String,String>>();

  String? date;
  String? local;

  Stream<String> get outDate => _date.stream;

  Stream<String> get outLocal => _local.stream;

  Stream<Map<String,String>> get outInfos => _info.stream;

  Function(String) get dateValue => _date.sink.add;

  Function(String) get localValue => _local.sink.add;

  void setDate() {
    date = _date.value;
    _info.sink.add({
      "data": date ?? "",
      "local": local ?? ""
    });
  }

  void setLocal() {
    String setor;
    if(_local.value == "RU - SETOR NORTE") {
      setor = "2";
    } else {
      setor = "1";
    }
    local = setor;
    _info.sink.add({
      "data": date ?? "",
      "local": local ?? ""
    });
  }


  @override
  void dispose() {
    _date.close();
    _local.close();
    super.dispose();
  }

}