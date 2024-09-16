import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/util/dialog_box.dart';
import 'package:to_do_list/util/list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  final _controller = TextEditingController();

  // Selected date for date picker
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // Function to pick a date
  void _pickDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (newDate != null) {
      setState(() {
        selectedDate = newDate; // Update the selected date
      });
    }
  }

  // Save new task
  void saveNewTask() {
    setState(() {
      db.tileVal.add([_controller.text, false, <String>[]]);
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  // Create a new task with a dialog
  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => {Navigator.of(context).pop()},
        );
      },
    );
  }

  // Mark a task as selected
  void boxSelected(bool? value, int index) {
    setState(() {
      db.tileVal[index][1] = !db.tileVal[index][1];
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    // Format the selected date to show the day and full date
    final String formattedDate =
        DateFormat('EEEE, MMMM d').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff6a11cb),
                Color(0xff2575fc),
              ],
            ),
          ),
        ),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'To Do\'s',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _pickDate,
                child: Text(
                  formattedDate,
                  style: GoogleFonts.lato(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: db.tileVal.length,
        itemBuilder: (context, index) {
          return TaskTile(
            taskName: db.tileVal[index][0],
            isSelected: db.tileVal[index][1],
            taskList: db.tileVal[index][2],
            onChanged: (value) => boxSelected(value, index),
            onDelete: () {
              setState(() {
                db.tileVal.removeAt(index);
              });
              db.updateData();
            },
          );
        },
      ),
    );
  }
}
