import 'package:flutter/material.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/task/domain/usecase/update_task_use_case.dart';
import 'package:trackbuzz/features/task/presentation/widgets/app_bar_task.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/shared/widgets/TextFieldCustom.dart';
import 'package:trackbuzz/shared/widgets/TextFieldDescription.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class UpdateTask extends StatefulWidget {
  final int id;
  final String img;
  final String name;
  final String description;

  const UpdateTask({
    super.key,
    required this.id,
    required this.img,
    required this.name,
    required this.description,
  });

  static Route<void> route(
    int id,
    String img,
    String name,
    String description,
  ) {
    return MaterialPageRoute(
      builder: (context) =>
          UpdateTask(id: id, img: img, name: name, description: description),
    );
  }

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool loading = false;

  _load(bool value) {
    setState(() {
      loading = value;
    });
  }

  Future<void> _update(String error) async {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      message(context, error);
      return;
    }
    _load(true);
    UpdateTaskUseCase(
      sl(),
    ).execute(_nameController.text, _descriptionController.text, widget.id);
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    _nameController.text = widget.name;
    _descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBarTask(
        title: loc?.translate('update_task') ?? 'Create Task',
        img: widget.img,
      ),
      floatingActionButton: !loading
          ? FloatingActionButton(
              onPressed: () async {
                await _update(loc?.translate('error_field') ?? 'Error');
              },
              child: Icon(
                Icons.send_sharp,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          : const SizedBox.shrink(),
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
