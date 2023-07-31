import 'dart:ui';

import 'package:currencies_project/logic/settings/settings_bloc.dart';
import 'package:currencies_project/models/models/currency.dart';
import 'package:currencies_project/pages/widgets/drag_handle.dart';
import 'package:currencies_project/pages/widgets/loading_app_bar_action.dart';
import 'package:currencies_project/tools/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/settings/settings_repository.dart';
import '../logic/settings/settings_state.dart';
import '../tools/tool_functions.dart';
import 'widgets/common_row.dart';
import 'widgets/currency_row_description.dart';

class SettingsPage extends StatefulWidget {
  final List<CurrencyPairModel> initModelsList;
  const SettingsPage({super.key, required this.initModelsList});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsCubit cubit;

  late List<CurrencyPairModel> initModelsList;
  late List<CurrencyPairModel> currentModelsList;

  @override
  void initState() {
    initModelsList = widget.initModelsList.copy().toList();
    currentModelsList = initModelsList.copy().toList();

    cubit = SettingsCubit(RepositoryProvider.of<SettingsRepository>(context));
    super.initState();
  }

  bool get hasDiff => !initModelsList.strongEquals(currentModelsList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройка валют'),
        actions: [
          BlocConsumer<SettingsCubit, SettingsCubitState>(
            listener: (context, state) {
              if (state is SettingsSaveCompletedState) {
                Navigator.of(context).pop();
              }
            },
            bloc: cubit,
            builder: (context, state) {
              if (state is SettingsSaveProgressState) {
                return const LoadingAppBarAction();
              }

              return IconButton(
                onPressed: !hasDiff
                    ? null
                    : () async {
                        cubit.saveSettings(currentModelsList);
                      },
                icon: Opacity(
                  opacity: hasDiff ? 1.0 : 0.3,
                  child: Icon(
                    Icons.done,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ReorderableListView(
        padding: listViewPadding(context),
        proxyDecorator: proxyDecorator,
        children: List.generate(
          currentModelsList.length,
          (index) => _ItemView(
            index: index,
            key: ValueKey(currentModelsList[index]),
            item: currentModelsList[index].first,
            enabled: currentModelsList[index].isEnabled,
            onChangedSwitch: (value) {
              currentModelsList[index] = currentModelsList[index].withEnabled(value);
              setState(() {});
            },
          ),
        ),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = currentModelsList.removeAt(oldIndex);
            currentModelsList.insert(newIndex, item);
          });
        },
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(lerpDouble(0, 12, animValue) ?? 0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  offset: const Offset(0.0, 3.0),
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(lerpDouble(0, 0.3, animValue) ?? 0),
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _ItemView extends StatelessWidget {
  final Currency item;
  final int index;
  final bool enabled;
  final void Function(bool value)? onChangedSwitch;

  const _ItemView(
      {super.key,
      required this.item,
      required this.index,
      required this.enabled,
      this.onChangedSwitch});

  @override
  Widget build(BuildContext context) {
    return RowView(
      descriptionWidget: CurrencyRowDescription(
        item: item,
      ),
      valueItemWidgets: [
        Switch.adaptive(key: ValueKey(item), value: enabled, onChanged: onChangedSwitch),
        ReorderableDragStartListener(
          index: index,
          child: const IconButton(onPressed: null, icon: DragHandle()),
        ),
      ],
    );
  }
}
