import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectInformation extends StatelessWidget
    implements PreferredSizeWidget {
  const ProjectInformation({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => ProjectInformation());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proyecto"),
        elevation: 0.0,
        actions: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              width: 37,
              child: Icon(CupertinoIcons.settings),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            margin: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent,
                          blurRadius: 10,
                          spreadRadius: 0.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://static.wikia.nocookie.net/rezero/images/e/ea/Rem_motivando_a_Subaru.gif/revision/latest?cb=20170809212028&path-prefix=es',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 5.0,
                                sigmaY: 5.0,
                              ),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 160,
                            width: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://static.wikia.nocookie.net/rezero/images/e/ea/Rem_motivando_a_Subaru.gif/revision/latest?cb=20170809212028&path-prefix=es',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    '6:39:51',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.blueAccent,
        child: Icon(
          CupertinoIcons.rectangle_stack_fill_badge_plus,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
