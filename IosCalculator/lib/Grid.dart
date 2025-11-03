import 'package:IosCalculator/button.dart';
import 'package:IosCalculator/button_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      crossAxisCount: 4,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        Button.icon(
          iconData: Icons.backspace_outlined,
          buttonColor: Color(0xff717577),
          buttonType: ButtonType.delete,
        ),
        Button.text(
          text: 'AC',
          buttonColor: Color(0xff717577),
          buttonType: ButtonType.deleteAll,
        ),
        Button.icon(
          iconData: CupertinoIcons.percent,
          buttonColor: Color(0xff717577),
          buttonType: ButtonType.addData,
          buttonContent: '%',
        ),
        Button.icon(
          iconData: CupertinoIcons.divide,
          buttonColor: Color(0xfffc8100),
          buttonType: ButtonType.addData,
          buttonContent: '÷',
        ),
        Button.text(
          text: '7',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '7',
        ),
        Button.text(
          text: '8',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '8',
        ),
        Button.text(
          text: '9',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '9',
        ),
        Button.icon(
          iconData: CupertinoIcons.multiply,
          buttonColor: Color(0xfffc8100),
          buttonType: ButtonType.addData,
          buttonContent: '×',
        ),
        Button.text(
          text: '4',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '4',
        ),
        Button.text(
          text: '5',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '5',
        ),
        Button.text(
          text: '6',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '6',
        ),
        Button.icon(
          iconData: CupertinoIcons.minus,
          buttonColor: Color(0xfffc8100),
          buttonType: ButtonType.addData,
          buttonContent: '-',
        ),
        Button.text(
          text: '1',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '1',
        ),
        Button.text(
          text: '2',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '2',
        ),
        Button.text(
          text: '3',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '3',
        ),
        Button.icon(
          iconData: CupertinoIcons.add,
          buttonColor: Color(0xfffc8100),
          buttonType: ButtonType.addData,
          buttonContent: '+',
        ),
        Button.text(
          text: ' ',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.doNothing,
        ),
        Button.text(
          text: '0',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: '0',
        ),
        Button.text(
          text: ',',
          buttonColor: Color(0xff454a4c),
          buttonType: ButtonType.addData,
          buttonContent: ',',
        ),
        Button.icon(
          iconData: CupertinoIcons.equal,
          buttonColor: Color(0xfffc8100),
          buttonType: ButtonType.calculate,
        ),
      ],
    );
  }
}
