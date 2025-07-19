import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trackbuzz/core/setting/theme_notifier.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_bloc.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_event.dart';
import 'package:trackbuzz/features/project/presentation/bloc/SettingProject/setting_project_state.dart';
import 'package:trackbuzz/features/project/presentation/widgets/AlerDialogText.dart';
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

  DrawerSetting({super.key, required this.settingProjectBloc});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
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
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Icon(
                    CupertinoIcons.smiley,
                    size: 60,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 10),
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
                        icon: CupertinoIcons.money_dollar,
                        text: loc?.translate('bill') ?? 'Bill',
                      ),
                      BlocBuilder<SettingProjectBloc, SettingProjectState>(
                        builder: (contextBloc, state) {
                          if (state is SettingProjectLoading) {
                            return PreLoader();
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
                            return SizedBox.shrink();
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
                        return PreLoader();
                      } else if (state is SettingProjectLoaded) {
                        return GestureDetector(
                          onTap:
                              () =>
                                  state.setting.bill == 1
                                      ? showDialog(
                                        context: contextBloc,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return Alerdialogtext(
                                                title:
                                                    loc?.translate(
                                                      'update_value',
                                                    ) ??
                                                    'Update Value',
                                                controller: _valueController,
                                                keyboardType:
                                                    TextInputType.numberWithOptions(
                                                      decimal: true,
                                                    ),
                                                save: () {
                                                  if (double.tryParse(
                                                            _valueController
                                                                .text,
                                                          ) !=
                                                          null &&
                                                      _valueController
                                                          .text
                                                          .isNotEmpty) {
                                                    contextBloc
                                                        .read<
                                                          SettingProjectBloc
                                                        >()
                                                        .add(
                                                          ChangePrice(
                                                            price: double.parse(
                                                              _valueController
                                                                  .text,
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
                                color:
                                    state.setting.bill == 1
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.secondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.setting.price.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      state.setting.bill == 1
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
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
                        return PreLoader();
                      } else if (state is SettingProjectLoaded) {
                        return GestureDetector(
                          onTap:
                              () =>
                                  state.setting.bill == 1
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
                                                  if (_currencyController
                                                          .text !=
                                                      state.setting.coin) {
                                                    contextBloc
                                                        .read<
                                                          SettingProjectBloc
                                                        >()
                                                        .add(
                                                          ChangeCoin(
                                                            coin:
                                                                _currencyController
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
                                color:
                                    state.setting.bill == 1
                                        ? Theme.of(
                                          context,
                                        ).colorScheme.secondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                state.setting.coin,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      state.setting.bill == 1
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<SettingProjectBloc, SettingProjectState>(
                  builder: (context, state) {
                    if (state is SettingProjectLoading) {
                      return PreLoader();
                    } else if (state is SettingProjectLoaded) {
                      return state.update
                          ? Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: GestureDetector(
                              onTap: () {
                                context.read<SettingProjectBloc>().add(
                                  UpdateSetting(),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    loc?.translate('save') ?? 'Save',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          : SizedBox.shrink();
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
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
                      SizedBox(width: 20),
                      GestureDetector(
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
