import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cardapio_ufam/validators/suggestion_validator.dart';
import 'package:rxdart/rxdart.dart';

class SuggestionBloc extends BlocBase with SuggestionValidator{

  final _titleController = BehaviorSubject<String>();
  final _textController = BehaviorSubject<String>();

  Stream<String> get outTitle => _titleController.stream.transform(validateTitle);
  Stream<String> get outText => _textController.stream.transform(validateText);
  Stream<bool> get outFilled => Rx.combineLatest2(outTitle, outText, (a, b) => true);

  Function(String) get changeTitle => _titleController.sink.add;
  Function(String) get changeText => _textController.sink.add;

  void printValues() {

  }

  @override
  void dispose() {
    _titleController.close();
    _textController.close();
    super.dispose();
  }

}