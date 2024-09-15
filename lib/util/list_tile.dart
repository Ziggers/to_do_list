import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskTile extends StatefulWidget {
  final String taskName;
  final bool isSelected;
  final List<String> taskList;
  final Function(bool?)? onChanged;

  const TaskTile({
    super.key,
    required this.taskName,
    required this.isSelected,
    required this.taskList,
    required this.onChanged,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  final TextEditingController _editController = TextEditingController();
  final TextEditingController _newTaskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

void _addSubtask() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add New Task'),
      content: TextField(
        controller: _newTaskController,
        decoration: const InputDecoration(hintText: 'Enter new task'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_newTaskController.text.isNotEmpty) {
              setState(() {
                widget.taskList.add(_newTaskController.text);
                db.updateSubtask(widget.taskName, _newTaskController.text);
                _newTaskController.clear();

              });
            }
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}

  void _editSubtask(int index) {
    _editController.text = widget.taskList[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit item'),
        content: TextField(
          controller: _editController,
          decoration: const InputDecoration(hintText: 'Add item'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.taskList[index] = _editController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(value: widget.isSelected, onChanged: widget.onChanged),
                const SizedBox(width: 10),
                Text(
                  widget.taskName,
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.taskList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.taskList[index]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        onPressed: () => _editSubtask(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 18),
                        onPressed: () => setState(() => widget.taskList.removeAt(index)),
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: _addSubtask,
                  ),
                  const Text("List item"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}