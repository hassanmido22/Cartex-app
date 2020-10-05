import 'package:flutter/material.dart';
import 'package:gp_login_screen/Providers/filter_products.dart';
import 'package:gp_login_screen/Screens/search_products.dart';
import 'package:provider/provider.dart';

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

class EntryItem extends StatefulWidget {
  const EntryItem(this.entry);

  final Entry entry;

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  bool toogle = false;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(root.title),
        onTap: () {
          ProductsFilter productsFilter = Provider.of<ProductsFilter>(context);
          productsFilter.setSerch('');
          productsFilter.setNext(null);
          productsFilter.setPrev(null);
          productsFilter
              .fetchProducts(brands: [], feats: [], category: [root.title]);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductsSearch()),
          );
        },
      );
    return ExpansionTile(
      onExpansionChanged: (x) {
        setState(() {
          toogle = x;
        });
      },
      key: PageStorageKey<Entry>(root),
      leading: Icon(Icons.category,color: Colors.black54,),
      title: Text(root.title,
          style: TextStyle(
            color: Colors.black54,
          )),
      trailing: toogle
          ? Icon(
              Icons.keyboard_arrow_up,
              color: Colors.black54,
            )
          : Icon(Icons.keyboard_arrow_down, color: Colors.black54),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(widget.entry);
  }
}
