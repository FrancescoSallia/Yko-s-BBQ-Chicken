import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ykos_bbq_chicken/Pages/detail_page.dart';
import 'package:ykos_bbq_chicken/theme/colors.dart';
import 'package:ykos_bbq_chicken/viewmodel/viewmodel_menu.dart';

class MySearchField extends StatefulWidget {
  final ValueChanged<int>
  onCategorySelected; // ✅ Callback für selectedCategoryIndex

  const MySearchField({super.key, required this.onCategorySelected});

  @override
  State<MySearchField> createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewmodelMenu>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModelMenu = context.read<ViewmodelMenu>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
      child: Theme(
        //to change background color from controller.open() View
        data: Theme.of(context).copyWith(
          searchViewTheme: SearchViewThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
        ),
        child: SearchAnchor(
          builder: (context, controller) {
            return SearchBar(
              trailing: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: Icon(Icons.cancel, size: 20),
                  ),
                ),
              ],
              elevation: WidgetStatePropertyAll(2),
              controller: controller,
              hintText: "Search by category or product...",
              leading: const Icon(Icons.search),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onTap: () => controller.openView(),
              onChanged: (value) => controller.openView(),
            );
          },
          suggestionsBuilder: (context, controller) {
            final query = controller.text.toLowerCase();

            if (query.isEmpty) return [];

            // Kategorien filtern
            final categories =
                viewModelMenu
                    .getCategoriesFromFoods(viewModelMenu.menuList)
                    .where(
                      (category) => category.name.toLowerCase().contains(query),
                    )
                    .toList();

            // Foods filtern
            final foods =
                viewModelMenu.menuList
                    .where(
                      (food) =>
                          food.name.toLowerCase().contains(query) ||
                          food.category.name.toLowerCase().contains(query),
                    )
                    .toList();

            // Gemeinsame Ergebnisliste
            final allResults = [
              ...categories.map(
                (category) => {
                  "type": "category",
                  "name": category.name,
                  "img": category.categoryImg,
                },
              ),
              ...foods.map(
                (food) => {
                  "type": "food",
                  "name": food.name,
                  "category": food.category.name,
                  "img": food.imgAsset,
                  // food.category.name == CategoryEnum.drinks.label
                  //     ? Icons.local_drink
                  //     : Icons.fastfood,
                },
              ),
            ];

            return allResults.map((item) {
              final isCategory = item["type"] == "category";
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isCategory ? AppColors.primary : Colors.lightBlue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    trailing:
                        isCategory
                            ? Icon(
                              Icons.category_rounded,
                              color: AppColors.primary,
                            )
                            : Icon(
                              Icons.arrow_right,
                              color: Colors.lightBlueAccent,
                            ),
                    leading:
                        isCategory
                            ? Image.asset(
                              item["img"] ?? "",
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "lib/img/logo_ykos.png", // Fallback, falls Bild fehlt oder Pfad falsch
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                            : Image.asset(
                              item["img"] ?? "",
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "lib/img/logo_ykos.png", // Fallback, falls Bild fehlt oder Pfad falsch
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                    // Icon(
                    //   isCategory ? Icons.category : item["img"] as IconData,
                    //   color: isCategory ? Colors.orange : Colors.redAccent,
                    // ),
                    title: Text(
                      item["name"] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle:
                        isCategory
                            ? const Text('Category')
                            : Text('Category: ${item['category']}'),
                    onTap: () {
                      controller.closeView(item['name'] as String);
                      if (isCategory) {
                        // Kategorie laden

                        final index = viewModelMenu.indexOfCategory(
                          item["name"] ?? "",
                        );
                        // 🔄 Statt setState -> Callback aufrufen
                        widget.onCategorySelected(index);
                        viewModelMenu.loadMenuFromCategory(
                          item['name'] as String,
                        );
                      } else {
                        // Produkt anzeigen
                        final selectedFood = viewModelMenu.menuList.firstWhere(
                          (f) => f.name == item['name'],
                        );
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder:
                                (context) => DetailPage(item: selectedFood),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
