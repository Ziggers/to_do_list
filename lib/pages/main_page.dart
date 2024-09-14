import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/util/dialog_box.dart';
import 'package:to_do_list/util/list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  void createTask(){
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox();
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // Get the current date
    final DateTime now = DateTime.now();
    // Format the date to show day and full date
    final String formattedDate = DateFormat('EEEE, MMMM d').format(now);

    return Scaffold(
        // App bar //
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 83, 120, 255),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Text with a smaller font size and different font style
              Text(
                formattedDate,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontStyle: FontStyle.italic, // Add some design to the font
                ),
              ),

              Text(
                'To Do List',
                style: GoogleFonts.robotoCondensed(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

      floatingActionButton:  FloatingActionButton(
        onPressed: createTask,
        child: const Icon(Icons.add),
      ),

      body: ListView(
        children: [
          TaskTile(taskName: "Finish Tile Feat", isSelected: true, onChanged:(p0) {
            
          },),
        ], 
      )
      );
  }
}



