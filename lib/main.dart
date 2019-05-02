import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home()
));

const MESSAGE_INFO_TEXT = "Informe os seus dados!";

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  
  String _infoText = MESSAGE_INFO_TEXT;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    _weightController.text = "";
    _heightController.text = "";

    _formKey.currentState.reset();

    setState(() {
      _infoText = MESSAGE_INFO_TEXT;
    });
  }

  void _calculate() {
    
    setState(() {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100.0;
      double imc = weight / (height * height);

      if(imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9) {
        _infoText = "Levement Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40.0) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: _weightController,
                validator: (value) {
                  return value.isEmpty ? "Insira o seu peso" : null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: _heightController,
                validator: (value) {
                  return value.isEmpty ? "Insira a sua altura" : null;
                },
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                  child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                  color: Colors.green,
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }

}