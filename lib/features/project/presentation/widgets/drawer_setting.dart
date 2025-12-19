import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:trackbuzz/core/di/injection_container.dart';
import 'package:trackbuzz/features/project/domain/usecase/delete_project_use_case.dart';
import 'package:trackbuzz/features/project/domain/usecase/get_record_without_page_use_case.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/Project/project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_state.dart';
import 'package:trackbuzz/features/project/presentation/pages/project_update.dart';
import 'package:trackbuzz/features/project/presentation/widgets/AlerDialogText.dart';
import 'package:trackbuzz/shared/functions/export_to_csv.dart';
import 'package:trackbuzz/shared/functions/message.dart';
import 'package:trackbuzz/shared/functions/notification_download.dart';
import 'package:trackbuzz/shared/functions/time_format_record.dart';
import 'package:trackbuzz/shared/widgets/adjustments_announced.dart';
import 'package:trackbuzz/shared/widgets/pre_loader.dart';
import 'package:trackbuzz/shared/widgets/switch_custom.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class DrawerSetting extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController(
    text: '10',
  );
  final TextEditingController _currencyController = TextEditingController(
    text: 'USD',
  );

  final SettingProjectBloc settingProjectBloc;
  final ProjectBloc projectBloc;
  final int idProject;

  DrawerSetting({
    super.key,
    required this.settingProjectBloc,
    required this.projectBloc,
    required this.idProject,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return BlocProvider.value(
      value: settingProjectBloc,
      child: BlocListener<SettingProjectBloc, SettingProjectState>(
        listener: (context, state) {
          if (state is SettingProjectLoaded) {
            _valueController.text = state.setting.price.toString();
            _currencyController.text = state.setting.coin;
          }
        },
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.75,
          child: SafeArea(
            child: ListView(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Icon(
                    CupertinoIcons.smiley,
                    size: 60,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    loc?.translate('settings') ?? 'Settings',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdjustmentsAnnounced(
                        icon: CupertinoIcons.power,
                        text: loc?.translate('state') ?? 'State',
                      ),
                      BlocBuilder<SettingProjectBloc, SettingProjectState>(
                        builder: (contextBloc, state) {
                          if (state is SettingProjectLoading) {
                            return const PreLoader();
                          } else if (state is SettingProjectLoaded) {
                            return SwitchCustom(
                              light: state.state == 0 ? true : false,
                              onChanged: (value) {
                                contextBloc.read<SettingProjectBloc>().add(
                                  ChangeState(state: value ? 0 : 1),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdjustmentsAnnounced(
                        icon: CupertinoIcons.text_aligncenter,
                        text: loc?.translate('description') ?? 'Description',
                      ),
                      BlocBuilder<SettingProjectBloc, SettingProjectState>(
                        builder: (contextBloc, state) {
                          if (state is SettingProjectLoading) {
                            return const PreLoader();
                          } else if (state is SettingProjectLoaded) {
                            return SwitchCustom(
                              light: state.setting.description == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                contextBloc.read<SettingProjectBloc>().add(
                                  ChangeDescription(description: value ? 1 : 0),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdjustmentsAnnounced(
                        icon: CupertinoIcons.money_dollar,
                        text: loc?.translate('bill') ?? 'Bill',
                      ),
                      BlocBuilder<SettingProjectBloc, SettingProjectState>(
                        builder: (contextBloc, state) {
                          if (state is SettingProjectLoading) {
                            return const PreLoader();
                          } else if (state is SettingProjectLoaded) {
                            return SwitchCustom(
                              light: state.setting.bill == 1 ? true : false,
                              onChanged: (value) {
                                contextBloc.read<SettingProjectBloc>().add(
                                  ChangeBill(bill: value ? 1 : 0),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: AdjustmentsAnnounced(
                    icon: CupertinoIcons.money_dollar_circle,
                    text: loc?.translate('value_per_hour') ?? 'Value per Hour',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: BlocBuilder<SettingProjectBloc, SettingProjectState>(
                    builder: (contextBloc, state) {
                      if (state is SettingProjectLoading) {
                        return const PreLoader();
                      } else if (state is SettingProjectLoaded) {
                        return GestureDetector(
                          onTap: () => state.setting.bill == 1
                              ? showDialog(
                                  context: contextBloc,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Alerdialogtext(
                                          title:
                                              loc?.translate('update_value') ??
                                              'Update Value',
                                          controller: _valueController,
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                decimal: true,
                                              ),
                                          save: () {
                                            if (double.tryParse(
                                                      _valueController.text,
                                                    ) !=
                                                    null &&
                                                _valueController
                                                    .text
                                                    .isNotEmpty) {
                                              contextBloc
                                                  .read<SettingProjectBloc>()
                                                  .add(
                                                    ChangePrice(
                                                      price: double.parse(
                                                        _valueController.text,
                                                      ),
                                                    ),
                                                  );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                )
                              : null,
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: BoxBorder.all(
                                color: state.setting.bill == 1
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(
                                        context,
                                      ).colorScheme.secondary.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                /*
                                NumberFormat.decimalPattern(
                                      loc?.locale.languageCode == 'en'
                                          ? 'en_US'
                                          : 'es_ES',
                                    )
                                    .format(state.setting.price.toInt())
                                    .toString(),
                                    */
                                '${state.setting.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: state.setting.bill == 1
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.secondary
                                            .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: AdjustmentsAnnounced(
                    icon: CupertinoIcons.doc_append,
                    text: loc?.translate('currency') ?? 'Currency',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: BlocBuilder<SettingProjectBloc, SettingProjectState>(
                    builder: (contextBloc, state) {
                      if (state is SettingProjectLoading) {
                        return const PreLoader();
                      } else if (state is SettingProjectLoaded) {
                        return GestureDetector(
                          onTap: () => state.setting.bill == 1
                              ? showDialog(
                                  context: contextBloc,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Alerdialogtext(
                                          title:
                                              loc?.translate(
                                                'change_currency',
                                              ) ??
                                              'Change Currency',
                                          controller: _currencyController,
                                          save: () {
                                            if (_currencyController.text !=
                                                state.setting.coin) {
                                              contextBloc
                                                  .read<SettingProjectBloc>()
                                                  .add(
                                                    ChangeCoin(
                                                      coin: _currencyController
                                                          .text,
                                                    ),
                                                  );
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                )
                              : null,
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: BoxBorder.all(
                                color: state.setting.bill == 1
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(
                                        context,
                                      ).colorScheme.secondary.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.setting.coin,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: state.setting.bill == 1
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.secondary
                                            .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: AdjustmentsAnnounced(
                    icon: CupertinoIcons.folder,
                    text: loc?.translate('download') ?? 'Download',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: GestureDetector(
                    onTap: () async {
                      final data = await GetRecordWithoutPageUseCase(
                        sl(),
                      ).execute(idProject);
                      List<Map<String, dynamic>> csv = [];
                      for (var i = 0; i < data.length; i++) {
                        final time = DateTime.parse(
                          data[i].finish!,
                        ).difference(DateTime.parse(data[i].start)).inSeconds;
                        csv.add({
                          'N': i + 1,
                          'date': data[i].start.substring(
                            0,
                            data[i].start.indexOf('T'),
                          ),
                          'activity': data[i].idTask == null
                              ? 'General'
                              : data[i].taskName,
                          'start': data[i].start.substring(
                            0,
                            data[i].start.lastIndexOf('.'),
                          ),
                          'finish': data[i].finish!.substring(
                            0,
                            data[i].finish!.lastIndexOf('.'),
                          ),
                          'time': timeFormatRecord(time),
                        });
                      }
                      final path = await exportToCsv(csv);
                      final bool notifications =
                          await Permission.notification.status.isGranted;

                      if (notifications) {
                        notificationDownload(path, 'download the file', loc);
                      } else {
                        message(
                          context,
                          '${loc?.translate('file_download') ?? 'downloaded file'}: $path',
                          5,
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'CSV',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<SettingProjectBloc, SettingProjectState>(
                  builder: (context, state) {
                    if (state is SettingProjectLoading) {
                      return const PreLoader();
                    } else if (state is SettingProjectLoaded) {
                      return state.update
                          ? Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<SettingProjectBloc>().add(
                                    UpdateSetting(),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      loc?.translate('save') ?? 'Save',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProjectUpdate(id: idProject),
                            ),
                          );
                          if (result == true) {
                            projectBloc.add(
                              UpdateBool(id: idProject, update: true),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.settings,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  loc?.translate('delete_title') ??
                                      'are you sure?',
                                ),
                                content: Text(
                                  loc?.translate('delete_description') ?? '',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                    ),
                                    child: Text(
                                      loc?.translate('cancel') ?? 'Cancel',
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                    ),
                                    child: Text(
                                      loc?.translate('accept') ?? 'Accept',
                                    ),
                                    onPressed: () async {
                                      await DeleteProjectUseCase(
                                        sl(),
                                      ).execute(idProject);
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.trash,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
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
    );
  }
}
