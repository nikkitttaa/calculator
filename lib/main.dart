import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculate()
    ));


class Calculate extends StatefulWidget {
  const Calculate({super.key});
  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
 
 Widget button(String btntxt, Color btncolor, Color txtcolor){
    return Container(
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).longestSide/100),
      decoration: BoxDecoration(shape: BoxShape.circle, color: btncolor),
      child: TextButton(onPressed: (){
        buttonPressed(btntxt);
      }, 
      child: Text(btntxt,
        style: TextStyle(color: txtcolor, fontSize: 35),
        ), 
      )
    );
  }
  
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Padding(padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: const EdgeInsets.all(1),
                  child: Text(equation, 
                  style: const TextStyle(color: Colors.white, fontSize: 70,),
                  textAlign: TextAlign.left,),
                  )
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(padding: const EdgeInsets.all(5),
                  child: Text(result, 
                  style: const TextStyle(color: Colors.grey, fontSize: 40,),
                  textAlign: TextAlign.left,),
                  )
            ]),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button('AC', Colors.grey[900]!, Colors.white),
                button('⌫', Colors.grey[900]!, Colors.white),
                button('%', Colors.grey[900]!, Colors.white),
                button('÷', Colors.grey[900]!, Colors.white)
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height/100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button('7', Colors.grey, Colors.black),
                button('8', Colors.grey, Colors.black),
                button('9', Colors.grey, Colors.black),
                button('×', Colors.grey[900]!, Colors.white)
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height/100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button('4', Colors.grey, Colors.black),
                button('5', Colors.grey, Colors.black),
                button('6', Colors.grey, Colors.black),
                button('-', Colors.grey[900]!, Colors.white)
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height/100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button('1', Colors.grey, Colors.black),
                button('2', Colors.grey, Colors.black),
                button('3', Colors.grey, Colors.black),
                button('+', Colors.grey[900]!, Colors.white)
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height/100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button('+/-', Colors.grey[900]!, Colors.white),
                button('0', Colors.grey, Colors.black),
                button('.', Colors.grey[900]!, Colors.white),
                button('=', Colors.orange, Colors.white)
              ],
            ),
          ],
        ),
      ),
    );
  }

 

   buttonPressed(String buttonText) {
    // used to check if the result contains a decimal
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}