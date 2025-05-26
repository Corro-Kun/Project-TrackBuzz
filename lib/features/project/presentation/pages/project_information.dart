import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/features/project/presentation/widgets/app_bar_information.dart';

class ProjectInformation extends StatefulWidget {
  const ProjectInformation({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => ProjectInformation());
  }

  @override
  State<ProjectInformation> createState() => _ProjectInformationState();
}

class _ProjectInformationState extends State<ProjectInformation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarInformation(),
      body: Column(
        children: [
          Container(
            height: 300,
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
          Container(
            child: TabBar(
              controller: _tabController,
              dividerHeight: 0,
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              tabs: [Tab(text: 'General'), Tab(text: 'Historial')],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.money_dollar_circle),
                          SizedBox(width: 5),
                          Text('facturación:', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: Text(
                          r'$43',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.calendar),
                          SizedBox(width: 5),
                          Text('Dias:', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.rectangle_paperclip),
                          SizedBox(width: 5),
                          Text('Tareas:', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jueves, 15 Mayo',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '1:14:59',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  'nombre de la tarea',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '0:42:23',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  'nombre de la tarea',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '0:24:23',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Miércoles, 14 Mayo',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            '0:57:59',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  'nombre de la tarea',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '0:57:59',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
