import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class CreateProject extends StatelessWidget {
  const CreateProject({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => CreateProject());
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc?.translate('create_project') ?? 'Create Project',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        elevation: 0.0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          CupertinoIcons.arrow_right,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: BoxBorder.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
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
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: 10,
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              loc?.translate('title_input') ?? 'Title:',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1,
                  ),
                ),
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
