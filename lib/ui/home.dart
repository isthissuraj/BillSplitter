

import 'package:flutter/material.dart';

import '../util/hexcolor.dart';




class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff03DAC5),
      appBar: AppBar(
        title: Text("Bill Splitter"),
        centerTitle: true,
        backgroundColor: Color(0xff6200EE),
      ),
    
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Color(0xff3700B3).withOpacity(0.2),
                  //Colors.purpleAccent.shade100,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Color(0xff3700B3)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "₹ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                        style: TextStyle(
                            fontSize: 34.9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3700B3)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: <Widget>[

                  TextField(

                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Color(0xff3700B3)),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xff3700B3))),
                          prefixText: "Bill Amount : ",
                          prefixIcon: Icon(Icons.currency_rupee)),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exception) {
                          _billAmount = 0.0;
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //do noting
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Color(0xff3700B3).withOpacity(0.1)),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Color(0xff3700B3),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: Color(0xff3700B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff3700B3).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Color(0xff3700B3),
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "₹ ${ (calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2) }",
                          style: TextStyle(
                              color: Color(0xff3700B3),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            color: Color(0xff3700B3),
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Color(0xff3700B3),
                          inactiveColor: Colors.grey.shade200,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newvalue) {
                            setState(() {
                              _tipPercentage = newvalue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;

    return totalPerPerson.toStringAsFixed(2) ;
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if (_billAmount < 0 ||
        billAmount.toString().isEmpty ||
        billAmount == null) {
      //no go!

    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }

    return totalTip;
  }
}






//                         // )
//                       ],
//                     ),
//                     // making a slider
//                     Column(
//                       children: [
//                         Text("$_tipPercentage%", style: TextStyle(
//                           color: Color(0xFF0DCC6C),
//                           fontSize: 17.0,
//                           fontWeight: FontWeight.bold
//                         ),),

//                         Slider(
//                           min: 0,
//                           max: 100,
//                           activeColor: Color(0xFF0DCC6C),
//                           inactiveColor: Color(0xFF0DCC6C).withOpacity(0.3),
//                           divisions: 20,
//                           value: _tipPercentage.toDouble(),
//                           onChanged: (double newValue){
//                           setState(() {
//                             _tipPercentage = newValue.round();
//                           });
//                         },)

//                       ],
//                     )

//                   ])
//               )],

//           ),
//         ),
//       ),
//     );
//   }
//   //first function
// calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage){

//  var totalPerPerson = (calculateTotalPerPerson( billAmount, splitBy, tipPercentage) + billAmount)/ splitBy;
//  return totalPerPerson.toStringAsFixed(2);
// }

// calculateTotalTip(double billAmount , int splitBill , int tipPercentage){
// double totalTip = 0.0;

// if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){
//   // don't do any thing
// }else{
//   totalTip = (billAmount * tipPercentage)/100;
// return totalTip;
// }

// }

// }
