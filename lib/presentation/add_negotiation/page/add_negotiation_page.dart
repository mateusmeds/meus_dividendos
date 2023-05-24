import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_dividends/core/dependency_injection.dart';
import 'package:my_dividends/domain/enums/stock_negotiation_type.dart';
import 'package:my_dividends/domain/models/stock_negotiation_model.dart';
import 'package:my_dividends/presentation/add_negotiation/bloc/add_negotiation_bloc.dart';
import 'package:my_dividends/presentation/add_negotiation/bloc/events/add_negotiation_event.dart';
import 'package:my_dividends/presentation/add_negotiation/bloc/states/add_negotiation_state.dart';
import 'package:my_dividends/presentation/add_negotiation/input_validation/input_validation.dart';
import 'package:my_dividends/utils/currency_input_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dividends/utils/date_formatter.dart';
import 'package:my_dividends/widgets/export.dart' show LoadingCenter, Menu;

class AddNegotiationPage extends StatefulWidget {
  const AddNegotiationPage({Key? key}) : super(key: key);

  @override
  State<AddNegotiationPage> createState() => _AddNegotiationPageState();
}

class _AddNegotiationPageState extends State<AddNegotiationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final _priceController = TextEditingController(text: 'R\$ 0,00');
  final _quantityController = TextEditingController();
  final _tickerController = TextEditingController();

  StockNegotiationType _selectedType = StockNegotiationType.buy;

  late final AddNegotiationBloc _addNegotiationBloc;

  @override
  void initState() {
    _addNegotiationBloc = getDependency<AddNegotiationBloc>();
    _addNegotiationBloc.add(GetAllAvailableTickersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _addNegotiationBloc.add(GetAllAvailableTickersEvent());
        _clearFields();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Negociações'),
        ),
        drawer: const Menu(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BlocConsumer<AddNegotiationBloc, AddNegotiationState>(
              bloc: _addNegotiationBloc,
              listener: (context, state) {
                if (state is SaveNegotiationSuccessState) {
                  _clearFields();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Negociação salva com sucesso!"),
                    ),
                  );
                }

                if (state is SaveNegotiationErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }

                if (state is SaveNegotiationLoadingState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Salvando...'),
                    ),
                  );
                }
              },
              buildWhen: (previous, current) {
                if (current is GetAllAvailableTickersSuccessState ||
                    current is GetAllAvailableTickersErrorState ||
                    current is GetAllAvailableTickersLoadingState) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is GetAllAvailableTickersLoadingState) {
                  return const LoadingCenter();
                } else if (state is GetAllAvailableTickersErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is GetAllAvailableTickersSuccessState) {
                  return ListView(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 100,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 4,
                                    child: RadioListTile<StockNegotiationType>(
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Compra'),
                                      value: StockNegotiationType.buy,
                                      groupValue: _selectedType,
                                      onChanged: (StockNegotiationType? value) {
                                        setState(() {
                                          _selectedType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 4,
                                    child: RadioListTile<StockNegotiationType>(
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: EdgeInsets.zero,
                                      title: const Text('Venda'),
                                      value: StockNegotiationType.sell,
                                      groupValue: _selectedType,
                                      onChanged: (StockNegotiationType? value) {
                                        setState(() {
                                          _selectedType = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Date',
                                hintText: 'Enter the date',
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (value) =>
                                  InputValidation.validateDate(value),
                              onTap: _showDatePicker,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _tickerController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.code_outlined),
                                labelText: 'Código da ação',
                                hintText: 'ex: KLBN4',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onChanged: (_) =>
                                  _transformToUpperCase(_tickerController),
                              validator: (value) =>
                                  InputValidation.validateTicker(
                                value,
                                state.tickers,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Quantidade de ações',
                                hintText: 'ex: 100',
                                prefixIcon:
                                    const Icon(Icons.onetwothree_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (value) =>
                                  InputValidation.validateQuantity(value),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyPtBrInputFormatter()
                              ],
                              decoration: InputDecoration(
                                labelText: 'Preço por ação',
                                prefixIcon: const Icon(Icons.attach_money),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (value) =>
                                  InputValidation.validatePrice(value),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _addNegotiationBloc.add(
                SaveNegotiationEvent(
                  StockNegotiationModel(
                    date: DateFormatter.fromBrToUTC(_dateController.text),
                    ticker: _tickerController.text,
                    quantity: int.parse(_quantityController.text),
                    pricePerStock: CurrencyPtBrInputFormatter
                        .parseCurrencyFormattedStringToDouble(
                      _priceController.text,
                    ),
                    type: _selectedType,
                  ),
                ),
              );
            }
          },
          label: const Text('SALVAR'),
          icon: const Icon(Icons.save),
        ),
      ),
    );
  }

  void _transformToUpperCase(TextEditingController textEditingController) {
    textEditingController.text = textEditingController.text.toUpperCase();
    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: textEditingController.text.length,
      ),
    );
  }

  void _showDatePicker() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');

    await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(hours: 3)),
      firstDate: DateTime(1970),
      lastDate: DateTime.now().subtract(const Duration(hours: 3)),
    ).then(
      (date) {
        if (date == null) {
          return;
        }
        _dateController.text = DateFormat('dd/MM/y').format(date);
      },
    );
  }

  void _clearFields() {
    _dateController.clear();
    _tickerController.clear();
    _quantityController.clear();
    _priceController.text = 'R\$ 0,00';
  }
}
