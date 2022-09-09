import 'package:flutter/material.dart';
import 'package:hive_and_provider/constants/padding.dart';
import 'package:hive_and_provider/constants/strings.dart';
import 'package:hive_and_provider/model/tasks.dart';
import 'package:hive_and_provider/viewmodel/home_page_viewmodel.dart';
import 'package:hive_and_provider/widget/custom_cupertino_button.dart';
import 'package:hive_and_provider/widget/custom_text_field.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController titleController;
  late final TextEditingController noteController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    Hive.box(taskBox).close();
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            sap(),
            const SList(),
          ],
        ),
        floatingActionButton: Fab(titleController: titleController, noteController: noteController, formKey: formKey),
      ),
    );
  }

  SliverAppBar sap() {
    return SliverAppBar.medium(
      title: const Text(appTitle),
    );
  }
}

class SList extends StatelessWidget {
  const SList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, value, child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: value.box.length,
            (context, index) {
              final task = value.box.getAt(index) as Tasks;

              return Card(
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.note),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(areyousure),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text(no)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Provider.of<HomePageViewModel>(context, listen: false).removeAt(index);
                                    },
                                    child: const Text(deleteit)),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete_outline)),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class Fab extends StatelessWidget {
  const Fab({
    Key? key,
    required this.titleController,
    required this.noteController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController noteController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        titleController.clear();
        noteController.clear();

        showModalBottomSheet(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          context: context,
          builder: (context) {
            return Card(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const AppPadding.all(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          controller: titleController,
                          textInputAction: TextInputAction.next,
                          hintText: titlecomeshere,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 6,
                        child: CustomTextField(
                          controller: noteController,
                          textInputAction: TextInputAction.done,
                          hintText: notecomeshere,
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: CustomCupertinoButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Provider.of<HomePageViewModel>(context, listen: false).add(
                                Tasks(
                                  title: titleController.text,
                                  note: noteController.text,
                                ),
                              );

                              Navigator.pop(context);

                              titleController.clear();
                              noteController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
