import 'package:currencies_project/logic/currency/currency_bloc.dart';
import 'package:currencies_project/logic/currency/currency_repository.dart';
import 'package:currencies_project/pages/settings_page.dart';
import 'package:currencies_project/pages/widgets/error_view.dart';
import 'package:currencies_project/pages/widgets/loading_app_bar_action.dart';
import 'package:currencies_project/pages/widgets/texts_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/currency/currency_states.dart';
import '../models/models/currency.dart';
import '../tools/extensions.dart';
import '../tools/tool_functions.dart';
import 'widgets/common_row.dart';
import 'widgets/currency_row_description.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CurrencyCubit cubit;

  @override
  void initState() {
    cubit = CurrencyCubit(RepositoryProvider.of<CurrencyRepository>(context))..loadCurrencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Курсы валют'),
        actions: [
          BlocBuilder<CurrencyCubit, CurrencyCubitState>(
            bloc: cubit,
            builder: (context, state) {
              if (state.data.isNullOrEmpty) {
                return Container();
              }

              if (state is CurrencyCubitLoadingState) {
                return const LoadingAppBarAction();
              }

              if (state is CurrencyCubitHasDataState) {
                return IconButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          initModelsList: state.data,
                        ),
                      ),
                    );
                    cubit.loadCurrencies();
                  },
                  icon: const Icon(Icons.settings),
                );
              }

              //Any Other State
              return Container();
            },
          ),
        ],
      ),
      body: BlocBuilder<CurrencyCubit, CurrencyCubitState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is CurrencyCubitLoadingState && state.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = state.data;
          if (!data.isNullOrEmpty) {
            final pair = data!.first;

            if (data.where((element) => element.isEnabled).isEmpty) {
              return const ErrorView(
                text: 'Отсутствуют отображаемые валюты\n\nПопробуйте изменить настройки',
              );
            }

            return Column(
              children: [
                Container(
                  height: 44,
                  color: colorScheme.onBackground.withOpacity(0.1),
                  child: RowView(
                    descriptionWidget: const SizedBox(),
                    valueItemWidgets: [
                      DateText(date: pair.first.date),
                      DateText(date: pair.second.date),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: listViewPadding(context),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final dataItem = data[index];
                      return Visibility(
                        visible: dataItem.isEnabled,
                        child: _ItemView(
                          item: (dataItem.first, dataItem.second),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return ErrorView(
            text: 'Не удалось получить курсы валют',
            bottomView: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ElevatedButton(
                child: Text(
                  'Попробовать снова',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                onPressed: () {
                  cubit.loadCurrencies();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ItemView extends StatelessWidget {
  final (Currency, Currency) item;

  const _ItemView({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return RowView(
      descriptionWidget: CurrencyRowDescription(
        item: item.$1,
      ),
      valueItemWidgets: [
        RateText(rate: item.$1.rate),
        RateText(rate: item.$2.rate),
      ],
    );
  }
}
