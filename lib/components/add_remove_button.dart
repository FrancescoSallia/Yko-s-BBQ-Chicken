import 'package:flutter/material.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';

class AddRemoveButton extends StatefulWidget {
  final Food item;
  final Function(Food) gesture;
  const AddRemoveButton({super.key, required this.item, required this.gesture});

  @override
  State<AddRemoveButton> createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: AppColors.secondaryButton,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryButton.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (widget.item.count > 1) {
                  widget.item.count--;
                  widget.gesture(widget.item);
                }
              });
            },
            icon: Icon(Icons.remove, color: AppColors.primaryButton),
            iconSize: 17,
            style: IconButton.styleFrom(minimumSize: Size(17, 17)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.item.count.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryButton,
                fontSize: 14,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.item.count++;
                widget.gesture(widget.item);
              });
            },
            icon: Icon(Icons.add, color: AppColors.primaryButton),
            iconSize: 17,
            style: IconButton.styleFrom(minimumSize: Size(20, 20)),
          ),
        ],
      ),
    );
  }
}
