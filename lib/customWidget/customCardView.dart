import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String expense;
  final void Function()? onPressed;
  final void Function()? onPressed2;

  CardView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.expense,
    required this.onPressed,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Container(
          width: MediaQuery.sizeOf(context).width * .85,
          decoration: BoxDecoration(
            color: Color(0xffD9D9D9),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Color(0x56000000),
                offset: Offset(
                  0,
                  4,
                ),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    Row(
                      children: [
                        IconButton(
                            onPressed: onPressed,
                            icon: Icon(Icons.edit_rounded)),
                        IconButton(
                            onPressed: onPressed2, icon: Icon(Icons.delete))
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width * .45,
                        child: Text('Description: $subtitle')),
                    Column(
                      children: [
                        Text('Expense: ₹$expense'),
                        Text('Date: $date')
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
