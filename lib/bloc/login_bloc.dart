import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cardapio_ufam/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

enum LoginStatus {
  start,
  idle,
  loading,
  fail,
  success,
}

class LoginBloc extends BlocBase with LoginValidator {
  LoginBloc() {
    _statusController.add(LoginStatus.start);
  }

  late String token;
  String? date;

  String get getToken => token;
  String? get getDate => date;

  final _cpfController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _statusController = BehaviorSubject<LoginStatus>();
  
  Stream<String> get outCpf => _cpfController.stream.transform(validateCpf);

  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  
  Stream<LoginStatus> get outStatus => _statusController.stream;

  Stream<bool> get outSubmitValue =>
      Rx.combineLatest2(outCpf, outPassword, (a, b) => true);

  Function(String) get changeCpf => _cpfController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  final dio = Dio(BaseOptions(
    baseUrl: "https://ruwebservicedev.ufam.edu.br/",
    contentType: "application/json",
  ),);

  Future<void> submit() async {
    var cpf = _cpfController.value;
    final password = _passwordController.value;

    cpf = cpf.replaceAll(".", "");
    cpf = cpf.replaceAll("-", "");

    try {
      Response response = await dio.post("v1/login", data: {"usuario": cpf, "senha": password});
      token = response.data["token"];
      _statusController.add(LoginStatus.success);
    } catch (e){
      _statusController.add(LoginStatus.fail);
    }

  }

  void setToken(String tk, String dt, bool logOff) {
    if(logOff) {
      signOut();
    } else {
      if(tk != "") {
        token = tk;
        date = dt;
        _statusController.add(LoginStatus.success);
      } else {
        token = "";
        _statusController.add(LoginStatus.start);
      }
    }
  }



  void signOut(){
    // sign out
    token = "";
    _statusController.add(LoginStatus.idle);
  }

  @override
  void dispose() {
    _cpfController.close();
    _passwordController.close();
    _statusController.close();
    super.dispose();
  }
}
