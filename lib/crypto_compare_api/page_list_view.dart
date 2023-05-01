import 'package:flutter/material.dart';

class PageListView<T> extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final List<int>? pageSizes;
  final Future<List<T>> Function(int pageIndex, int pageSize) fetchPage;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final void Function(int pageIndex)? onPageView;

  const PageListView({
    Key? key,
    this.padding,
    this.pageSizes,
    required this.fetchPage,
    required this.itemBuilder,
    this.onPageView,
  }) : super(key: key);

  @override
  _PageListViewState<T> createState() => _PageListViewState<T>();
}

class _PageListViewState<T> extends State<PageListView<T>> {
  final _controller = ScrollController();
  final _items = <T>[];
  int _currentPageIndex = 0;
  int get _currentPageSize => widget.pageSizes![_currentPageIndex];

  @override
  void initState() {
    super.initState();
    _fetchPage();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _fetchPage();
      }
    });
  }

  Future<void> _fetchPage() async {
    final pageIndex = _items.length ~/ _currentPageSize;
    final pageSize = widget.pageSizes![pageIndex];
    final items = await widget.fetchPage(pageIndex, pageSize);
    setState(() {
      _items.addAll(items);
      _currentPageIndex = pageIndex + 1;
    });
    widget.onPageView?.call(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: widget.padding,
      controller: _controller,
      itemCount: _items.length,
      itemBuilder: (context, index) =>
          widget.itemBuilder(context, _items[index], index),
    );
  }
}
