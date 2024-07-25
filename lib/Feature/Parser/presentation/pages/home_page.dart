import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_page_analyzer/Core/Utils/validator/url_validator.dart';
import 'package:web_page_analyzer/Feature/Parser/presentation/widgets/table_widget.dart';

import '../bloc/parser_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController urlController;
  final _formKey = GlobalKey<FormState>();
  // String? _errorMessage;
  @override
  void initState() {
    // TODO: implement initState
    urlController = TextEditingController();
    super.initState();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process data here (e.g., send to server)
      // For demonstration purposes, we'll just print the URL
      print('Valid URL: ${urlController.text}');
      context.read<ParserBloc>().add(FetchInfo(url: urlController.text));
      // setState(() {
      //   _errorMessage = null;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ParserBloc, ParserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                    maxWidth: size.width > 1024 ? 1024 : size.width * 1),
                // width: size.width * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      // SizedBox(
                      //   height: size.height * 0.4,
                      // ),
                      Text(
                        "WEBPAGE ANALYZER",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      if (size.width > 422)
                        Container(
                          alignment: Alignment.center,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  // width: size.width > constraints.maxWidth
                                  //     ? constraints.maxWidth * 0.1
                                  //     : size.width * 0.1,
                                  decoration: const BoxDecoration(
                                    color: Colors.black12,
                                  ),
                                  child: const Icon(Icons.link),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: size.height * 0.06,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      controller: urlController,

                                      // cursorHeight: size.height * 0.02,
                                      validator: (value) {
                                        return validateUrl(value);
                                      },
                                      decoration: const InputDecoration(
                                        // errorText: _errorMessage,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 12),
                                        hintText:
                                            "Please enter the URL you want to parse",
                                        // border: OutlineInputBorder(),
                                        border: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        // border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _submitForm();
                                    print("Clicked: ${urlController.text}");
                                  },
                                  child: Container(
                                    height: size.height * 0.06,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer),
                                    child: const Text("Submit"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (size.width < 422)
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: size.height * 0.045,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // width: size.width > constraints.maxWidth
                                        //     ? constraints.maxWidth * 0.1
                                        //     : size.width * 0.1,
                                        decoration: const BoxDecoration(
                                          color: Colors.black12,
                                        ),
                                        child: const Icon(Icons.link),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        height: size.height * 0.045,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        child: Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            controller: urlController,

                                            // cursorHeight: size.height * 0.02,
                                            validator: (value) {
                                              return validateUrl(value);
                                            },
                                            decoration: const InputDecoration(
                                              // errorText: _errorMessage,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 12),
                                              hintText:
                                                  "Please enter the URL you want to parse",
                                              // border: OutlineInputBorder(),
                                              border: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              // border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _submitForm();
                                  print("Clicked: ${urlController.text}");
                                },
                                child: Container(
                                  height: size.height * 0.04,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  child: const Text("Submit"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 50,
                      ),

                      if (state is ParserLoading)
                        const CircularProgressIndicator(),
                      if (state is ParserDisplay)
                        TableWidget(
                          htmlModel: state.htmlModel,
                        ),
                      if (state is ParserError)
                        Column(
                          children: [
                            const Text(
                              "Something went wrong",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 0.4,
                            ),
                            Text("${state.error}")
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
