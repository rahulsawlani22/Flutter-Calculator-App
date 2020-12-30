import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme : ThemeData(primarySwatch: Colors.red),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFont = 30.0;
  double resultFont = 40.0;


  buttonPressed(String buttonText)
  {
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFont = 30.0;
        resultFont = 40.0;
      }
      else if(buttonText == "⌫"){
        equation = equation.substring(0,equation.length - 1);
        if(equation == "")
          equation = "0";
        equationFont = 30.0;
        resultFont = 40.0;
      }
      else if(buttonText == "="){
        equationFont = 30.0;
        resultFont = 40.0;
        expression = equation;
        expression = expression.replaceAll('×', "*");
        expression = expression.replaceAll('÷', "/");
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result = "Error";
        }
      }
      else {
        equationFont = 30.0;
        resultFont = 40.0;
        if(equation == "0"){
          equation = buttonText;
        }else{
        equation = equation + buttonText;
      }
    }});
  }
  Widget BuildButton(String buttonText, double buttonHeight, Color buttonColor){
    return   Container(
      height:  MediaQuery.of(context).size.width*buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.2),
          side: BorderSide(color: Colors.white,width: 1,style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: ()=>buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding:EdgeInsets.fromLTRB(10, 20, 20, 0),
            child:Text(equation,style: TextStyle(fontSize: equationFont),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding:EdgeInsets.fromLTRB(10, 30, 20, 0),
            child:Text(result,style: TextStyle(fontSize: resultFont),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                      BuildButton("C", 0.2, Colors.redAccent),
                        BuildButton("⌫", 0.2, Colors.green),
                        BuildButton("+", 0.2, Colors.green),
                        // BuildButton("-", 0.2, Colors.redAccent),
                        // BuildButton("/", 0.2, Colors.redAccent),
                        // BuildButton("X", 0.2, Colors.redAccent),
                      ]
                    ),
                    TableRow(
                        children: [
                          BuildButton("7", 0.2, Colors.blue),
                          BuildButton("8", 0.2, Colors.blue),
                          BuildButton("9", 0.2, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton("4", 0.2, Colors.blue),
                          BuildButton("5", 0.2, Colors.blue),
                          BuildButton("6", 0.2, Colors.blue),
                        ]
                    ),  TableRow(
                        children: [
                          BuildButton("1", 0.2, Colors.blue),
                          BuildButton("2", 0.2, Colors.blue),
                          BuildButton("3", 0.2, Colors.blue),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton(".", 0.2, Colors.blue),
                          BuildButton("0", 0.2, Colors.blue),
                          BuildButton("00", 0.2, Colors.blue),
                        ]
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width* 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildButton("-", 0.2, Colors.green),
                      ]
                    ),
                    TableRow(
                        children: [
                          BuildButton("×", 0.2, Colors.green),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton("÷", 0.2, Colors.green),
                        ]
                    ),
                    TableRow(
                        children: [
                          BuildButton("=", 0.4, Colors.redAccent),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
