import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textInput1 = TextEditingController();
  TextEditingController _textInput2 = TextEditingController();
  TextEditingController _textInput3 = TextEditingController();

  bool _isCheck1 = false;
  bool _isCheck2 = false;
  bool _isCheck3 = false;

  double _result = 0;

  @override
  void dispose() {
    _textInput1.dispose();
    _textInput2.dispose();
    _textInput3.dispose();
    super.dispose();
  }

  void _checkBox1() {
    setState(() {
      _isCheck1 = !_isCheck1;
    });
  }

  void _checkBox2() {
    setState(() {
      _isCheck2 = !_isCheck2;
    });
  }

  void _checkBox3() {
    setState(() {
      _isCheck3 = !_isCheck3;
    });
  }

  void _calculate(BuildContext context, String opr) {
    List<double> _inputList = [];
    double sum;

    if (_isCheck1 && _textInput1.text.isNotEmpty) {
      _inputList.add(double.parse(_textInput1.text));
    }
    if (_isCheck2 && _textInput2.text.isNotEmpty) {
      _inputList.add(double.parse(_textInput2.text));
    }
    if (_isCheck3 && _textInput3.text.isNotEmpty) {
      _inputList.add(double.parse(_textInput3.text));
    }

    if (_inputList.length < 2) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Text Input harus diisi minimal 2'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    _inputList.forEach((number) {
      switch (opr) {
        case '+':
          print('add');
          sum = sum == null ? sum = number : sum + number;
          break;
        case '-':
          print('sub');
          sum = sum == null ? sum = number : sum - number;
          break;
        case 'x':
          print('multi');
          sum = sum == null ? sum = number : sum * number;
          break;
        case '/':
          print('div');
          sum = sum == null ? sum = number : sum / number;
          break;
      }
    });

    setState(() {
      _result = sum;
    });
  }

  Widget _inputWithCheckbox(
      TextEditingController inputController, bool isCheck, Function check) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            controller: inputController,
            keyboardType: TextInputType.number,
          ),
        ),
        Checkbox(
          value: isCheck,
          onChanged: (value) => check(),
        ),
      ],
    );
  }

  Widget _buttonCalculate(BuildContext context, String opr) {
    return GestureDetector(
      onTap: () {
        _calculate(context, opr);
      },
      child: Container(
        height: 30,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            opr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _inputWithCheckbox(_textInput1, _isCheck1, _checkBox1),
            _inputWithCheckbox(_textInput2, _isCheck2, _checkBox2),
            _inputWithCheckbox(_textInput3, _isCheck3, _checkBox3),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buttonCalculate(context, '+'),
                _buttonCalculate(context, '-'),
                _buttonCalculate(context, 'x'),
                _buttonCalculate(context, '/'),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hasil',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '${_result.toStringAsFixed(_result.truncateToDouble() == _result ? 0 : 2)}',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
