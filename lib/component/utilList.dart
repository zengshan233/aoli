import 'dart:async';

import 'package:aoli/events/eventBus.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class UtilList extends StatefulWidget {
  final int itemCount;
  final ItemScrollController controller;
  final int beforeCount;
  final int initialIndex;
  final Widget footer;
  final Widget header;
  final Future Function() onLoadMore;
  final Future Function() onLoadBefore;
  final Widget Function(int) itemBuilder;
  final bool reverse;
  final bool loadMoreDone;
  final bool loadBeforeDone;
  final double bottomContentPadding;
  UtilList(
      {this.itemCount,
      this.controller,
      this.beforeCount,
      this.initialIndex,
      this.footer,
      this.header,
      this.onLoadBefore,
      this.onLoadMore,
      this.itemBuilder,
      this.loadMoreDone = false,
      this.loadBeforeDone = false,
      this.reverse = false,
      this.bottomContentPadding});
  @override
  _UtilListState createState() => _UtilListState();
}

class _UtilListState extends State<UtilList> {
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  ItemScrollController itemScrollController;

  bool showLoadMore = false;
  bool showLoadBefore = false;
  bool showBottomPadding = false;
  bool firstIndexFlag = false;

  int firstIndex = 1;
  @override
  void initState() {
    super.initState();
    itemScrollController = widget.controller ?? ItemScrollController();
    itemPositionsListener.itemPositions.addListener(() {
      List<ItemPosition> itemList =
          itemPositionsListener.itemPositions.value.toList();
      if (itemList.isNotEmpty) {
        ItemPosition lastItem = itemList.last;
        List<ItemPosition> _itemList = itemList.map((e) => e).toList();
        _itemList.sort((a, b) => a.index - b.index);
        if ((lastItem.index== widget.itemCount + 1 ) &&
            lastItem.itemTrailingEdge <= 0.98 &&
            !showLoadMore) {
          loadMore();
        }
      }
      if (firstIndex == 0 && !showLoadBefore) {
        loadBefore();
      }
    });

    EventBus.instance.addListener(EventKeys.AddBottomPadding, (map) {
      if (!showBottomPadding) {
        setState(() {
          showBottomPadding = true;
        });
      }
    });
    EventBus.instance.addListener(EventKeys.HideBottomPadding, (map) {
      setState(() {
        showBottomPadding = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    itemPositionsListener.itemPositions.removeListener(() {});
  }

  loadMore() async {
    if (widget.loadMoreDone) {
      return;
    }
    setState(() {
      showLoadMore = true;
    });
    await widget.onLoadMore();
    setState(() {
      showLoadMore = false;
    });
  }

  loadBefore() async {
    if (widget.loadBeforeDone) {
      return;
    }
    setState(() {
      showLoadBefore = true;
    });
    firstIndexFlag = true;
    firstIndex = 1;
    if (widget.onLoadBefore != null) {
      await widget.onLoadBefore();
      setState(() {
        showLoadBefore = false;
      });
    }

    if (widget.beforeCount != null && widget.beforeCount > 0) {
      jumpTo(widget.beforeCount);
    }
    await Future.delayed(Duration(milliseconds: 10));
    firstIndexFlag = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: list(),
          ),
          positionsView
        ],
      ),
    );
  }

  Widget list() => ScrollablePositionedList.builder(
      padding: EdgeInsets.only(bottom: (showBottomPadding? widget.bottomContentPadding: 0)),
      itemCount: widget.itemCount+2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _loadBeforeWidget();
        }
        if (index == widget.itemCount + 1) {
          return _loadMoreWidget();
        } else {
        return widget.itemBuilder(index - 1);
        }
      },
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      reverse: widget.reverse,
      initialScrollIndex: widget.initialIndex ?? 0,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical);

  Widget _loadMoreWidget() {
    return Visibility(
        visible: showLoadMore,
        child: widget.footer ??
            new Padding(
              padding: const EdgeInsets.all(15.0), // 外边距
              child: new Center(child: new CircularProgressIndicator()),
            ));
  }

  Widget _loadBeforeWidget() {
    return Visibility(
        visible: showLoadBefore,
        child: widget.header ??
            new Padding(
              padding: const EdgeInsets.all(15.0), // 外边距
              child: new Center(child: new CircularProgressIndicator()),
            ));
  }

  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          if (positions.isNotEmpty && !firstIndexFlag) {
            firstIndex = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
                    position.itemTrailingEdge < min.itemTrailingEdge
                        ? position
                        : min)
                .index;
          }
          return Container();
        },
      );

  void jumpTo(int index) => itemScrollController.jumpTo(index: index);
}
