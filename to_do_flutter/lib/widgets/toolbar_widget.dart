import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/providers/all_provider.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int oncompletedTodoCount = ref
        .watch(todoListProvider)
        .where((element) => !element.completed)
        .length;

        final filter=ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(oncompletedTodoCount.toString()),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(onPressed: () {
                               ref.read(todoListFilter.notifier).state= TodoListFilter.all;

          }, child: const Text('All')),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(onPressed: () {
            ref.read(todoListFilter.notifier).state= TodoListFilter.active;
          }, child: const Text('Active')),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(onPressed: () {
                         ref.read(todoListFilter.notifier).state= TodoListFilter.completed;

          }, child: const Text('Completed')),
        ),
      ],
    );
  }
}
