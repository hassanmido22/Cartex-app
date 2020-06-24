import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:gp_login_screen/Screens/filterAppbar.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FilterScreen extends StatefulWidget {
  //const FilterScreen({Key key}) : super(key: key);
  static const String appTitle = "Search Choices demo";

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final String loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  String selectedValue;
  List<String> itemss = [];
  List<int> selectedItems = [];

  final List<String> _list = [
    'samasung',
    'apple',
    'oneplus',
    'xamoi',
    'huwawei',
  ];
  List _items;
  //List<String> itemsss= _list.toList();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final List<DropdownMenuItem> items = [];
  Widget dropdown() {
    return SearchableDropdown.multiple(
      items: items,
      //icon: Image.asset('assets/download.svg'),
      //icon: Icon(Icons.),
      selectedItems: selectedItems,
      hint: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text("Brand"),
      ),
      searchHint: "Select any",
      onChanged: (value) {
        setState(() {
          selectedItems = value;
        });
      },
      closeButton: (selectedItems) {
        return (selectedItems.isNotEmpty
            ? "Save ${selectedItems.length == 1 ? '"' + items[selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
            : "Save without selection");
      },
      isExpanded: true,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    String wordPair = "";
    loremIpsum
        .toLowerCase()
        .replaceAll(",", "")
        .replaceAll(".", "")
        .split(" ")
        .forEach((word) {
      if (wordPair.isEmpty) {
        wordPair = word + " ";
      } else {
        wordPair += word;
        if (items.indexWhere((item) {
              return (item.value == wordPair);
            }) ==
            -1) {
          items.add(
            DropdownMenuItem(
              child: Text(wordPair),
              value: wordPair,
            ),
          );
        }
        wordPair = "";
      }
      itemss.add(wordPair);
      print(itemss);
    });
    //super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            width: 300,
            //decoration: BoxDecoration(boxShadow: <BoxShadow>[
            //BoxShadow(
            //  color: Colors.black12,
            //  blurRadius: 6.0,
            // offset: Offset(0.0, 3))
            //], color: Colors.white),
            //height: 40,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    dropdown(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                //Text(items[selectedItems.first].value.toString())
              ],
            ),
          )
        ],
      ),
    );
  }
}
