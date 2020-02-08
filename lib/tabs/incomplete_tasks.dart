import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remid_me/providers/todos_model.dart';
import 'package:flutter_remid_me/widgets/task_list.dart';

class IncompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) => TaskList(
          tasks: todos.incompleteTasks,
        ),
      ),
    );
  }
}
