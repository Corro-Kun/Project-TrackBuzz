import 'package:flutter/material.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/task/domain/usecase/create_task_use_case.dart';
import 'package:trackbuzz/features/task/presentation/widgets/app_bar_task.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/shared/widgets/TextFieldCustom.dart';
import 'package:trackbuzz/shared/widgets/TextFieldDescription.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class CreateTask extends StatefulWidget {
  final int id;
  final String img;
  const CreateTask({super.key, required this.id, required this.img});

  static Route<void> route(int id, String img) {
    return MaterialPageRoute(
      builder: (context) => CreateTask(id: id, img: img),
    );
  }

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool loading = false;

  _load(bool value) {
    setState(() {
      loading = value;
    });
  }

  Future<void> _create(String error) async {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      message(context, error);
      return;
    }
    _load(true);
    CreateTaskUseCase(
      sl(),
    ).execute(_nameController.text, _descriptionController.text, widget.id);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBarTask(
        title: loc?.translate('create_task') ?? 'Create Task',
        img: widget.img,
      ),
      floatingActionButton: !loading
          ? FloatingActionButton(
              onPressed: () async {
                await _create(loc?.translate('error_field') ?? 'Error');
              },
              child: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : SizedBox.shrink(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 20,
              bottom: 10,
            ),
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              loc?.translate('name') ?? 'Name',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextFieldCustom(controller: _nameController),
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
              loc?.translate('description') ?? 'Description',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextFieldDescription(controller: _descriptionController),
          ),
        ],
      ),
    );
  }
}
