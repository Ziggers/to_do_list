import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskTile extends StatefulWidget {
  final String taskName;
  final bool isSelected;
  final Function(bool?)? onChanged;

  const TaskTile({
    super.key,
    required this.taskName,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(value: widget.isSelected, onChanged: widget.onChanged),
                const SizedBox(width: 10),
                Text(widget.taskName,
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          const Divider(thickness: 2),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          )
          ],
        ),
      ),
    );
  }
}