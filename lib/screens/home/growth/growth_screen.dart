import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/growth/add_records_screen.dart';
import 'package:Viiddo/screens/home/growth/record_item.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bezier_chart/bezier_chart.dart';

class GrowthScreen extends StatefulWidget {
  MainScreenBloc bloc;

  GrowthScreen({
    this.bloc,
  });

  @override
  _GrowthScreenState createState() => _GrowthScreenState();
}

class _GrowthScreenState extends State<GrowthScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<DataPoint> _items;
  List<double> _xAxis;

  int _selectedIndex = 0;
  bool isEmpty = false;
  bool sendButtonEnabled = false;

  void _loadData() async {
    await Future.delayed(Duration(seconds: 3));
    final String data =
        '[{"Day":1,"Value":"5"},{"Day":2,"Value":"2"},{"Day":3,"Value":"6"},{"Day":4,"Value":"8"}]';
    final List list = json.decode(data);
    setState(() {
      _items = list
          .map((item) => DataPoint(
              value: double.parse(item["Value"].toString()),
              xAxis: double.parse(item["Day"].toString())))
          .toList();
      _xAxis =
          list.map((item) => double.parse(item["Day"].toString())).toList();
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, MainScreenState state) async {},
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return DefaultTabController(
            length: 3,
            initialIndex: _selectedIndex,
            child: Scaffold(
              appBar: new AppBar(
                title: Text('Growth'),
                backgroundColor: Colors.transparent,
                elevation: 0,
                textTheme: TextTheme(
                  headline6: TextStyle(
                    color: Color(0xFF7861B7),
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Color(0xFFFFA685),
                  size: 12,
                ),
                bottom: TabBar(
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        'Record List',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Height Chart',
                        style: TextStyle(
                          color: _selectedIndex == 1
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Weight Chart',
                        style: TextStyle(
                          color: _selectedIndex == 2
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Color(0xFFFAA382),
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      Navigation.toScreen(
                        context: context,
                        screen: AddRecordsScreen(
                          bloc: widget.bloc,
                        ),
                      );
                    },
                  ),
                ],
              ),
              key: scaffoldKey,
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Divider(
                      color: Color(0x75FAA382),
                      thickness: 2,
                      height: 0,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _recordsBody(state),
                          _heightChartBody(state),
                          _weightChartBody(state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _recordsBody(MainScreenState state) {
    return Container(
      alignment: Alignment.center,
      color: Color(0xFFFFFBF8),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GrowthRecordItem(
            index: index,
            function: () {},
          );
        },
      ),
    );
  }

  Widget _heightChartBody(MainScreenState state) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 14),
        ),
        Container(
          color: Colors.white,
          height: 220,
          width: MediaQuery.of(context).size.width * 0.9,
          child: BezierChart(
            bezierChartScale: BezierChartScale.CUSTOM,
            xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
            series: const [
              BezierLine(
                data: const [
                  DataPoint<double>(value: 10, xAxis: 0),
                  DataPoint<double>(value: 130, xAxis: 5),
                  DataPoint<double>(value: 50, xAxis: 10),
                  DataPoint<double>(value: 150, xAxis: 15),
                  DataPoint<double>(value: 75, xAxis: 20),
                  DataPoint<double>(value: 0, xAxis: 25),
                  DataPoint<double>(value: 5, xAxis: 30),
                  DataPoint<double>(value: 45, xAxis: 35),
                ],
              ),
            ],
            config: BezierChartConfig(
              verticalIndicatorColor: Colors.black26,
              showVerticalIndicator: true,
              backgroundColor: Colors.green,
              displayYAxis: true,
              stepsYAxis: 20,
              startYAxisFromNonZeroValue: true,
              displayLinesXAxis: true,
              xLinesColor: Colors.black,
              verticalLineFullHeight: true,
              showDataPoints: true,
              footerHeight: 44,
              bubbleIndicatorColor: Color(0xFFFFF5EF),
              snap: false,
            ),
          ),
        )
      ],
    );
  }

  Widget _weightChartBody(MainScreenState state) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset('assets/icons/no_post_yet.png'),
    );
  }

  Future<Null> _handleRefresh(context) {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();

    final data = [
      new LinearSales(0, random.nextInt(100)),
      new LinearSales(1, random.nextInt(100)),
      new LinearSales(2, random.nextInt(100)),
      new LinearSales(3, random.nextInt(100)),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
