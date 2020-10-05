import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:gp_login_screen/Models/product_item.dart';
import 'package:gp_login_screen/Screens/filterAppbar.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:gp_login_screen/Providers/filter_products.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterScreen extends StatefulWidget {
  static const String appTitle = "Search Choices demo";

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _searchController = TextEditingController();
  final _startPriceController = TextEditingController();
  final _endPriceController = TextEditingController();

  Widget dropdown(String name, int index) {
    return Consumer<ProductsFilter>(builder: (context, model, widgett) {
      return SearchableDropdown.multiple(
        items: model.getItems().elementAt(index),
        underline: "",
        displayClearIcon: false,
        hint: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(56, 52, 72, 1),
            ),
          ),
        ),
        icon: Padding(
          padding: EdgeInsets.only(right: 20, top: 10, bottom: 10),
          child: SvgPicture.asset(
            'assets/download.svg',
            color: Color.fromRGBO(112, 112, 112, 1),
            height: 20,
          ),
        ),
        searchHint: "Select any",
        onChanged: (List<int> value) {
          if (value.length > 0) {
            value.sort();
            List<String> list = [];

            value.forEach((f) => {
                  list.add(model.getItems().elementAt(index).elementAt(f).value)
                });

            if (model.selected.containsKey(name)) {
              model.selected[name].addAll(list);
            } else {
              model.selected.addAll({name: list});
            }

            List<String> brands = [];
            List<String> feats = [];

            if (model.selected.containsKey('Brand')) {
              brands = model.selected['Brand'];
            }

            model.selected.forEach((f, x) {
              if (f != 'Brand') {
                feats.addAll(x);
              }
            });

            print(brands);
            print(feats);
            //model.setNext(null);
            //model.setPrev(null);
            model.fetchProducts(brands: brands, feats: feats, featname: name,category: []);
          }
        },
        closeButton: (selectedItems) {
          return (selectedItems.isNotEmpty
              ? "Save ${selectedItems.length == 1 ? '"' + model.getItems()[index][selectedItems.first].value.toString() + '"' : '(' + selectedItems.length.toString() + ')'}"
              : "Save without selection");
        },
        isExpanded: true,
      );
    });
  }

  singleFeature(String name, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: dropdown(name, index),
              ),
            ),
            Expanded(
                flex: 1,
                child: Center(child: Consumer<ProductsFilter>(
                  builder: (context, model, widgett) {
                    return GestureDetector(
                      onTap: () {
                        List<String> brands = [];
                        List<String> feats = [];

                        model.selected.remove(name);

                        if (model.selected.containsKey('Brand')) {
                          brands = model.selected['Brand'];
                        }

                        model.selected.forEach((f, x) {
                          if (f != 'Brand') {
                            feats.addAll(x);
                          }
                        });
                        //model.setNext(null);
                        //model.setPrev(null);
                        model.fetchProducts(
                            brands: brands, feats: feats, featname: name,category: []);
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(238, 76, 125, 1),
                            fontSize: 16),
                      ),
                    );
                  },
                )))
          ],
        ),
        Consumer<ProductsFilter>(
          builder: (context, model, widgett) {
            return (model.selected.containsKey(name))
                ? Container(
                    margin: EdgeInsets.all(20),
                    child: Tags(
                      itemCount: model.selected[name].length,
                      itemBuilder: (int i) {
                        return Tooltip(
                            message: model.selected[name].elementAt(i),
                            child: ItemTags(
                                textScaleFactor: 1.1,
                                activeColor: Color.fromRGBO(132, 132, 132, 1),
                                textActiveColor: Colors.white,
                                color: Color.fromRGBO(132, 132, 132, 1),
                                textColor: Colors.white,
                                padding: EdgeInsets.all(10),
                                title: model.selected[name].elementAt(i),
                                index: i,
                                removeButton: ItemTagsRemoveButton(
                                    icon: Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                    backgroundColor: Colors.transparent,
                                    onRemoved: () {
                                      // Remove the item from the data source.
                                      setState(() {
                                        // required
                                        List<String> brands = [];
                                        List<String> feats = [];

                                        if (model.selected[name].length == 1) {
                                          model.selected.remove(name);
                                          //model.selected[name] = [];
                                        } else {
                                          model.selected[name].removeAt(i);
                                        }

                                        if (model.selected
                                            .containsKey('Brand')) {
                                          brands = model.selected['Brand'];
                                        }

                                        model.selected.forEach((f, x) {
                                          if (f != 'Brand') {
                                            feats.addAll(x);
                                          }
                                        });
                                        //model.setNext(null);
                                        //model.setPrev(null);
                                        model.fetchProducts(
                                            brands: brands,
                                            feats: feats,
                                            category: [],
                                            featname: name);
                                      });
                                      return true;
                                    })));
                      },
                    ))
                : SizedBox(
                    height: 0,
                  );
          },
        ),
      ],
    );
  }

  RangeValues rangePrice;
  List<String> feats = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ProductsFilter f = Provider.of<ProductsFilter>(context);
    setState(() {
      rangePrice = RangeValues(f.getMinPrice(), f.getMaxPrice());
      _startPriceController.text = rangePrice.start.toStringAsFixed(0);
      _endPriceController.text = rangePrice.end.toStringAsFixed(0);
      feats = Provider.of<ProductsFilter>(context).getFeaturesNames();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<ProductsFilter>(context);
    return Scaffold(
      appBar: MyAppBar(),
      body: (filterProvider.getLoading())
          ? Container(
              height: 400,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(252, 252, 252, 1),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0.0, 3))
                      ],
                    ),
                    height: 50,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            feats = Provider.of<ProductsFilter>(context)
                                .getFeaturesNames();
                          } else {
                            feats = feats.where((f) {
                              value = value[0].toUpperCase() +
                                  "${value.length >= 2 ? value.substring(1) : ''}";
                              print(value);
                              return f.contains(value);
                            }).toList();
                          }
                        });
                      },
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(56, 52, 71, 1),
                          fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        border: InputBorder.none,
                        hintText: 'Search for feature name ..',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                          color: Color.fromRGBO(112, 112, 112, 1),
                        ),
                      ),
                    ),
                  ),
                  feats.length >= 1
                      ? new Expanded(
                          child:
                              //Column(
                              //children: <Widget>[
                              Container(
                            child: ListView.builder(
                                itemCount: feats.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return singleFeature(
                                      feats.elementAt(index), index);
                                }),
                          ),

                          //],
                          //)
                        )
                      : Center(
                          child: Text("There is no features"),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Price range",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(56, 52, 72, 1),
                          ),
                        ),
                        RangeSlider(
                            values: rangePrice,
                            inactiveColor: Colors.white,
                            min: filterProvider.getMinPrice(),
                            max: filterProvider.getMaxPrice(),
                            activeColor: Colors.grey,
                            onChanged: (RangeValues values) {
                              setState(() {
                                if (values.end - values.start >= 20) {
                                  rangePrice = values;
                                } else {
                                  if (rangePrice.start == values.start) {
                                    rangePrice = RangeValues(rangePrice.start,
                                        rangePrice.start + 20);
                                  } else {
                                    rangePrice = RangeValues(
                                        rangePrice.end - 20, rangePrice.end);
                                  }
                                }
                                _startPriceController.text =
                                    rangePrice.start.toStringAsFixed(0);
                                _endPriceController.text =
                                    rangePrice.end.toStringAsFixed(0);
                              });
                            },

                            //divisions: 10,
                            labels: RangeLabels(
                                '${rangePrice.start}', '${rangePrice.end}')),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(252, 252, 252, 1),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 3))
                            ],
                          ),
                          height: 50,
                          child: TextFormField(
                            controller: _startPriceController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(56, 52, 71, 1),
                                fontSize: 16),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(252, 252, 252, 1),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 3))
                            ],
                          ),
                          height: 50,
                          child: TextFormField(
                            controller: _endPriceController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(56, 52, 71, 1),
                                fontSize: 16),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
        shape: null,
        color: Colors.transparent,
        child: Container(
          color: Colors.white,
          height: 80,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    child: Consumer<ProductsFilter>(
                      builder: (context, model, widget) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Color.fromRGBO(236, 236, 236, 1),
                          onPressed: () {
                            List<String> brands = [];
                            List<String> feats = [];

                            if (model.selected.containsKey('Brand')) {
                              brands = model.selected['Brand'];
                            }

                            model.selected.forEach((f, x) {
                              if (f != 'Brand') {
                                feats.addAll(x);
                              }
                            });
                            //filterProvider.setNext(null);
                            //filterProvider.setPrev(null);
                            filterProvider.fetchProducts(
                                brands: brands,
                                feats: feats,
                                
                                min: rangePrice.start.toInt(),
                                max: rangePrice.end.toInt(),category: []);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Apply Filters",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(56, 52, 72, 1),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.settings)
                            ],
                          ),
                        );
                      },
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    child: Consumer<ProductsFilter>(
                      builder: (context, model, widget) {
                        return RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Color.fromRGBO(238, 76, 125, 1),
                          onPressed: () {
                            model.selected = {};
                            model.fetchProducts(brands: [], feats: [],category: []);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Clear All",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(236, 236, 236, 1),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                'assets/delete.svg',
                                color: Color.fromRGBO(236, 236, 236, 1),
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
