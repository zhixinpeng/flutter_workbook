import 'package:flutter/material.dart';
import 'package:flutter_workbook/common/style/theme.dart';

class TabbarWidget extends StatefulWidget {
  final TabType type;
  final List<Widget>? tabItems;
  final List<Widget> tabViews;
  final Widget? title;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? persistentFooterButtons;
  final Color? indicatorColor;
  final Widget? drawer;

  final List<BottomNavigationBarItem>? bottomNavigationBarItems;

  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onSinglePress;

  const TabbarWidget({
    Key? key,
    this.type: TabType.top,
    this.tabItems,
    required this.tabViews,
    this.title,
    this.resizeToAvoidBottomInset: true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.persistentFooterButtons,
    this.indicatorColor,
    this.drawer,
    this.bottomNavigationBarItems,
    this.onPageChanged,
    this.onSinglePress,
  }) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabbarWidget> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController _pageController = PageController();

  int _index = 0;

  @override
  void initState() {
    if (widget.type == TabType.top) {
      _tabController = TabController(vsync: this, length: (widget.tabItems ?? []).length);
    }
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  _navigationTapClick(index) {
    if (_index == index) return;
    setState(() {
      _index = index;
      widget.onPageChanged?.call(index);

      _pageController.jumpTo(MediaQuery.of(context).size.width * index);
      widget.onSinglePress?.call(index);
    });
  }

  _navigationPageChanged(index) {
    if (_index == index) return;
    setState(() {
      _index = index;
      _tabController?.animateTo(index);
      widget.onPageChanged?.call(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 顶部菜单栏
    if (widget.type == TabType.top) {
      return Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        floatingActionButton: SafeArea(
          child: widget.floatingActionButton ?? Container(),
        ),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: widget.persistentFooterButtons,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: TabBar(
            controller: _tabController,
            tabs: widget.tabItems!,
            indicatorColor: widget.indicatorColor,
            onTap: _navigationTapClick,
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: widget.tabViews,
          onPageChanged: _navigationPageChanged,
        ),
      );
    }

    // 底部菜单栏
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: widget.title,
      ),
      body: PageView(
        controller: _pageController,
        children: widget.tabViews,
        onPageChanged: _navigationPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: ThemeColors.white,
        unselectedItemColor: ThemeColors.subLightTextColor,
        currentIndex: _index,
        onTap: _navigationTapClick,
        items: widget.bottomNavigationBarItems!,
      ),
    );
  }
}

enum TabType { top, bottom }
