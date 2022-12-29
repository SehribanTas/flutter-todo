import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_flutter/providers/all_provider.dart';

import '../models/todo_model.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  TodoModel item;
  TodoListItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController textEditingController;
  bool _hasFocused = false;
  @override
  void initState() {
    _textFocusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocused = false;
          });
          ref.read(todoListProvider.notifier).edit(id: widget.item.id, newDescription: textEditingController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocused = true;

            _textFocusNode.requestFocus();
            textEditingController.text = widget.item.description;
          });
        },
        leading: Checkbox(
          value: widget.item.completed,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggle(widget.item.id);
          },
        ),
        title: _hasFocused
            ? TextField(
                controller: textEditingController,
                focusNode: _textFocusNode,
              )
            : Text(widget.item.description),
      ),
    );
  }
}
