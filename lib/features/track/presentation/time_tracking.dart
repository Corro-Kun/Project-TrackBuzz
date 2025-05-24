import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/shared/widgets/app_bar_main.dart';

class TimeTracking extends StatelessWidget {
  const TimeTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: 'Cronometro'),
      body: ListView(
        children: [
          Container(
            height: 300,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Center(
                  child: Text(
                    '00:25:00',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: GestureDetector(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(child: Icon(CupertinoIcons.pause_fill)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('Proyecto:', style: TextStyle(fontSize: 14)),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('Tarea (opcional):', style: TextStyle(fontSize: 14)),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: BoxBorder.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: Center(child: Icon(CupertinoIcons.add)),
          ),
        ],
      ),
    );
  }
}
