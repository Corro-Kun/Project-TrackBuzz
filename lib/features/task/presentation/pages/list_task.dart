import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackbuzz/features/task/presentation/widgets/app_bar_task.dart';

class ListTask extends StatelessWidget {
  final int idProject;
  final String img;
  const ListTask({super.key, required this.idProject, required this.img});

  static Route<void> route(int idProject, String img) {
    return MaterialPageRoute(
      builder: (context) => ListTask(idProject: idProject, img: img),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTask(img: img),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: Icon(
          CupertinoIcons.rectangle_stack_fill_badge_plus,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: BoxBorder.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ExpansionTile(
                  title: Text(
                    'test',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  //trailing: SizedBox.shrink(),
                  iconColor: Theme.of(context).colorScheme.secondary,
                  collapsedIconColor: Theme.of(context).colorScheme.primary,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: Text(
                        'hola dsjf dslfjklds jfldsj lfjdsl fjdsljf lsdjflsd jflsdjf ljsdf ljsdf jsdlf sdkljf l sdalf jsad',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(
                              CupertinoIcons.settings,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              CupertinoIcons.trash,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
