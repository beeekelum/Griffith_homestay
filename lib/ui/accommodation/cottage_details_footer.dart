import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homestay/widgets/app_widgets.dart';

class CottageDetailsFooter extends StatefulWidget {
  CottageDetailsFooter(this.cottage);

  final DocumentSnapshot cottage;

  @override
  _CottageDetailsFooterState createState() => _CottageDetailsFooterState();
}

class _CottageDetailsFooterState extends State<CottageDetailsFooter>
    with SingleTickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabs = [
      Tab(text: 'Accommodation'),
      Tab(text: 'Host Preferences'),
    ];

    _pages = [
      Container(),
      Container(
        child: Column(
          children: <Widget>[
            titleWidget2('Host parent\'s preferences'),
          ],
        ),
      ),
    ];

    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: _tabs,
            controller: _controller,
            indicatorColor: Colors.white,
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(300),
            child: TabBarView(
              children: _pages,
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }
}
