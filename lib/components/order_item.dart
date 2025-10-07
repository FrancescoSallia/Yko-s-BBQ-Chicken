import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/Sheet/sheet_note_page.dart';
import 'package:ykos_bbq_chicken/extension/my_extensions.dart';
import 'package:ykos_bbq_chicken/model/food.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class OrderItem extends StatefulWidget {
  final Food orderItem;
  const OrderItem({super.key, required this.orderItem});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewmodelMenu>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.watch<ViewmodelMenu>();
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.orderItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      widget.orderItem.price.toEuroString(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),

            Visibility(
              visible: widget.orderItem.extras!.isNotEmpty ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      widget.orderItem.extras!.isNotEmpty ? "Extras:" : "",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.orderItem.extras?.length,
              itemBuilder: (context, index) {
                final extra = widget.orderItem.extras?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "- ${extra!.anzahl}x ${extra.name} ",
                        style: GoogleFonts.inter(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "+${extra.price.toEuroString()}",
                        style: GoogleFonts.inter(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 6),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.6,
                          child: SheetNotePage(foodItem: widget.orderItem),
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(
                      alpha: 0.1,
                    ), // 🔹 Hintergrundfarbe
                    foregroundColor:
                        AppColors.primaryButton, // 🔹 Text/Icon-Farbe
                    side: BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ), // 🔹 Rahmen
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.edit_note_rounded, size: 18),
                      SizedBox(width: 5),
                      Text("Notiz"),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          final updatedItem = widget.orderItem;

                          updatedItem.count--;
                          if (updatedItem.count > 0) {
                            viewModelMenu.updateMeal(updatedItem);
                          } else if (updatedItem.count == 0) {
                            viewModelMenu.removeFromList(
                              viewModelMenu.cartList,
                              updatedItem,
                            );
                          }
                        });
                      },
                      icon: Icon(
                        widget.orderItem.count == 1
                            ? Icons.delete
                            : Icons.remove,
                      ),
                      iconSize: 16,
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            widget.orderItem.count == 1
                                ? Colors.red.withValues(alpha: 0.2)
                                : AppColors.primaryButton.withValues(
                                  alpha: 0.2,
                                ),
                        foregroundColor:
                            widget.orderItem.count == 1
                                ? Colors.red
                                : AppColors.primaryButton,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        widget.orderItem.count.toString(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          final updatedItem = widget.orderItem;
                          updatedItem.count++;
                          viewModelMenu.updateMeal(updatedItem);
                        });
                      },
                      icon: const Icon(Icons.add),
                      iconSize: 16,
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryButton,
                        minimumSize: const Size(32, 32),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            Visibility(
              visible: widget.orderItem.note!.isNotEmpty ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.orderItem.note!.isNotEmpty
                          ? "↳ ${widget.orderItem.note}"
                          : "",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      softWrap:
                          true, // 👈 Macht automatisch ein Umbruch wenn es auf true ist ansosnten bleibt es in der Zeile und kommt zu Overflowed!
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),

            Divider(color: Colors.black, thickness: 2.2, height: 0),
          ],
        ),
      ],
    );
  }
}
