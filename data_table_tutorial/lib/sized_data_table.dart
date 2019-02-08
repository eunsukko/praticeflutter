// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
// import 'colors.dart';
// import 'debug.dart';
// import 'divider.dart';
// import 'dropdown.dart';
// import 'icons.dart';
// import 'ink_well.dart';
// import 'material.dart';
// import 'theme.dart';
// import 'theme_data.dart';
// import 'tooltip.dart';

/// A material design data table.
///
/// Displaying data in a table is expensive, because to lay out the
/// table all the data must be measured twice, once to negotiate the
/// dimensions to use for each column, and once to actually lay out
/// the table given the results of the negotiation.
///
/// For this reason, if you have a lot of data (say, more than a dozen
/// rows with a dozen columns, though the precise limits depend on the
/// target device), it is suggested that you use a
/// [PaginatedDataTable] which automatically splits the data into
/// multiple pages.
// TODO(ianh): Also suggest [ScrollingDataTable] once we have it.
///
/// See also:
///
///  * [DataColumn], which describes a column in the data table.
///  * [DataRow], which contains the data for a row in the data table.
///  * [DataCell], which contains the data for a single cell in the data table.
///  * [PaginatedDataTable], which shows part of the data in a data table and
///    provides controls for paging through the remainder of the data.
///  * <https://material.google.com/components/data-tables.html>
class SizedDataTable extends StatelessWidget {
  /// Creates a widget describing a data table.
  ///
  /// The [columns] argument must be a list of as many [DataColumn]
  /// objects as the table is to have columns, ignoring the leading
  /// checkbox column if any. The [columns] argument must have a
  /// length greater than zero and must not be null.
  ///
  /// The [rows] argument must be a list of as many [DataRow] objects
  /// as the table is to have rows, ignoring the leading heading row
  /// that contains the column headings (derived from the [columns]
  /// argument). There may be zero rows, but the rows argument must
  /// not be null.
  ///
  /// Each [DataRow] object in [rows] must have as many [DataCell]
  /// objects in the [DataRow.cells] list as the table has columns.
  ///
  /// If the table is sorted, the column that provides the current
  /// primary key should be specified by index in [sortColumnIndex], 0
  /// meaning the first column in [columns], 1 being the next one, and
  /// so forth.
  ///
  /// The actual sort order can be specified using [sortAscending]; if
  /// the sort order is ascending, this should be true (the default),
  /// otherwise it should be false.
  SizedDataTable({
    Key key,
    @required this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    @required this.rows,
    this.headingRowHeight = 56.0,
    this.dataRowHeight = 48.0,
    this.tablePadding = 24.0,
    this.columnSpacing = 56.0,
  }) : assert(columns != null),
       assert(columns.isNotEmpty),
       assert(sortColumnIndex == null || (sortColumnIndex >= 0 && sortColumnIndex < columns.length)),
       assert(sortAscending != null),
       assert(rows != null),
       assert(!rows.any((DataRow row) => row.cells.length != columns.length)),
       _onlyTextColumn = _initOnlyTextColumn(columns),
       super(key: key);

  /// The configuration and labels for the columns in the table.
  final List<DataColumn> columns;

  /// The current primary sort key's column.
  ///
  /// If non-null, indicates that the indicated column is the column
  /// by which the data is sorted. The number must correspond to the
  /// index of the relevant column in [columns].
  ///
  /// Setting this will cause the relevant column to have a sort
  /// indicator displayed.
  ///
  /// When this is null, it implies that the table's sort order does
  /// not correspond to any of the columns.
  final int sortColumnIndex;

  /// Whether the column mentioned in [sortColumnIndex], if any, is sorted
  /// in ascending order.
  ///
  /// If true, the order is ascending (meaning the rows with the
  /// smallest values for the current sort column are first in the
  /// table).
  ///
  /// If false, the order is descending (meaning the rows with the
  /// smallest values for the current sort column are last in the
  /// table).
  final bool sortAscending;

  /// Invoked when the user selects or unselects every row, using the
  /// checkbox in the heading row.
  ///
  /// If this is null, then the [DataRow.onSelectChanged] callback of
  /// every row in the table is invoked appropriately instead.
  ///
  /// To control whether a particular row is selectable or not, see
  /// [DataRow.onSelectChanged]. This callback is only relevant if any
  /// row is selectable.
  final ValueSetter<bool> onSelectAll;

  /// The data to show in each row (excluding the row that contains
  /// the column headings). Must be non-null, but may be empty.
  final List<DataRow> rows;

  // Set by the constructor to the index of the only Column that is
  // non-numeric, if there is exactly one, otherwise null.
  final int _onlyTextColumn;
  static int _initOnlyTextColumn(List<DataColumn> columns) {
    int result;
    for (int index = 0; index < columns.length; index += 1) {
      final DataColumn column = columns[index];
      if (!column.numeric) {
        if (result != null)
          return null;
        result = index;
      }
    }
    return result;
  }

  // bool get _debugInteractive {
  //   return columns.any((DataColumn column) => column._debugInteractive)
  //       || rows.any((DataRow row) => row._debugInteractive);
  // }

  static final LocalKey _headingRowKey = UniqueKey();

  void _handleSelectAll(bool checked) {
    if (onSelectAll != null) {
      onSelectAll(checked);
    } else {
      for (DataRow row in rows) {
        if ((row.onSelectChanged != null) && (row.selected != checked))
          row.onSelectChanged(checked);
      }
    }
  }

  double headingRowHeight;
  double dataRowHeight;
  double tablePadding;
  double columnSpacing;
  static const double _sortArrowPadding = 2.0;
  static const double _headingFontSize = 12.0;
  static const Duration _sortArrowAnimationDuration = Duration(milliseconds: 150);
  static const Color _grey100Opacity = Color(0x0A000000); // Grey 100 as opacity instead of solid color
  static const Color _grey300Opacity = Color(0x1E000000); // Dark theme variant is just a guess.

  Widget _buildCheckbox({
    Color color,
    bool checked,
    VoidCallback onRowTap,
    ValueChanged<bool> onCheckboxChanged
  }) {
    Widget contents = Semantics(
      container: true,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: this.tablePadding, end: this.tablePadding / 2.0),
        child: Center(
          child: Checkbox(
            activeColor: color,
            value: checked,
            onChanged: onCheckboxChanged,
          ),
        ),
      ),
    );
    if (onRowTap != null) {
      contents = TableRowInkWell(
        onTap: onRowTap,
        child: contents,
      );
    }
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: contents,
    );
  }

  Widget _buildHeadingCell({
    BuildContext context,
    EdgeInsetsGeometry padding,
    Widget label,
    String tooltip,
    bool numeric,
    VoidCallback onSort,
    bool sorted,
    bool ascending,
  }) {
    if (onSort != null) {
      final Widget arrow = _SortArrow(
        visible: sorted,
        down: sorted ? ascending : null,
        duration: _sortArrowAnimationDuration,
      );
      const Widget arrowPadding = SizedBox(width: _sortArrowPadding);
      label = Row(
        textDirection: numeric ? TextDirection.rtl : null,
        children: <Widget>[ label, arrowPadding, arrow ],
      );
    }
    label = Container(
      padding: padding,
      height: this.headingRowHeight,
      alignment: numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          // TODO(ianh): font family should match Theme; see https://github.com/flutter/flutter/issues/3116
          fontWeight: FontWeight.w500,
          fontSize: _headingFontSize,
          height: math.min(1.0, this.headingRowHeight / _headingFontSize),
          color: (Theme.of(context).brightness == Brightness.light)
            ? ((onSort != null && sorted) ? Colors.black87 : Colors.black54)
            : ((onSort != null && sorted) ? Colors.white : Colors.white70),
        ),
        softWrap: false,
        duration: _sortArrowAnimationDuration,
        child: label,
      ),
    );
    if (tooltip != null) {
      label = Tooltip(
        message: tooltip,
        child: label,
      );
    }
    if (onSort != null) {
      label = InkWell(
        onTap: onSort,
        child: label,
      );
    }
    return label;
  }

  Widget _buildDataCell({
    BuildContext context,
    EdgeInsetsGeometry padding,
    Widget label,
    bool numeric,
    bool placeholder,
    bool showEditIcon,
    VoidCallback onTap,
    VoidCallback onSelectChanged,
  }) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    if (showEditIcon) {
      const Widget icon = Icon(Icons.edit, size: 18.0);
      label = Expanded(child: label);
      label = Row(
        textDirection: numeric ? TextDirection.rtl : null,
        children: <Widget>[ label, icon ],
      );
    }
    label = Container(
      padding: padding,
      height: this.dataRowHeight,
      alignment: numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
      child: DefaultTextStyle(
        style: TextStyle(
          // TODO(ianh): font family should be Roboto; see https://github.com/flutter/flutter/issues/3116
          fontSize: 13.0,
          color: isLightTheme
            ? (placeholder ? Colors.black38 : Colors.black87)
            : (placeholder ? Colors.white30 : Colors.white70),
        ),
        child: IconTheme.merge(
          data: IconThemeData(
            color: isLightTheme ? Colors.black54 : Colors.white70,
          ),
          child: DropdownButtonHideUnderline(child: label),
        )
      )
    );
    if (onTap != null) {
      label = InkWell(
        onTap: onTap,
        child: label,
      );
    } else if (onSelectChanged != null) {
      label = TableRowInkWell(
        onTap: onSelectChanged,
        child: label,
      );
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
//    assert(!_debugInteractive || debugCheckHasMaterial(context));

    final ThemeData theme = Theme.of(context);
    final BoxDecoration _kSelectedDecoration = BoxDecoration(
      border: Border(bottom: Divider.createBorderSide(context, width: 1.0)),
      // The backgroundColor has to be transparent so you can see the ink on the material
      color: (Theme.of(context).brightness == Brightness.light) ? _grey100Opacity : _grey300Opacity,
    );
    final BoxDecoration _kUnselectedDecoration = BoxDecoration(
      border: Border(bottom: Divider.createBorderSide(context, width: 1.0)),
    );

    final bool showCheckboxColumn = rows.any((DataRow row) => row.onSelectChanged != null);
    final bool allChecked = showCheckboxColumn && !rows.any((DataRow row) => row.onSelectChanged != null && !row.selected);

    final List<TableColumnWidth> tableColumns = List<TableColumnWidth>(columns.length + (showCheckboxColumn ? 1 : 0));
    final List<TableRow> tableRows = List<TableRow>.generate(
      rows.length + 1, // the +1 is for the header row
      (int index) {
        return TableRow(
          key: index == 0 ? _headingRowKey : rows[index - 1].key,
          decoration: index > 0 && rows[index - 1].selected ? _kSelectedDecoration
                                                            : _kUnselectedDecoration,
          children: List<Widget>(tableColumns.length)
        );
      },
    );

    int rowIndex;

    int displayColumnIndex = 0;
    if (showCheckboxColumn) {
      tableColumns[0] = FixedColumnWidth(this.tablePadding + Checkbox.width + this.tablePadding / 2.0);
      tableRows[0].children[0] = _buildCheckbox(
        color: theme.accentColor,
        checked: allChecked,
        onCheckboxChanged: _handleSelectAll,
      );
      rowIndex = 1;
      for (DataRow row in rows) {
        tableRows[rowIndex].children[0] = _buildCheckbox(
          color: theme.accentColor,
          checked: row.selected,
          onRowTap: () => row.onSelectChanged(!row.selected),
          onCheckboxChanged: row.onSelectChanged,
        );
        rowIndex += 1;
      }
      displayColumnIndex += 1;
    }

    for (int dataColumnIndex = 0; dataColumnIndex < columns.length; dataColumnIndex += 1) {
      final DataColumn column = columns[dataColumnIndex];
      final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(
        start: dataColumnIndex == 0 ? showCheckboxColumn ? this.tablePadding / 2.0 : this.tablePadding : this.columnSpacing / 2.0,
        end: dataColumnIndex == columns.length - 1 ? this.tablePadding : this.columnSpacing / 2.0,
      );
      if (dataColumnIndex == _onlyTextColumn) {
        tableColumns[displayColumnIndex] = const IntrinsicColumnWidth(flex: 1.0);
      } else {
        tableColumns[displayColumnIndex] = const IntrinsicColumnWidth();
      }
      tableRows[0].children[displayColumnIndex] = _buildHeadingCell(
        context: context,
        padding: padding,
        label: column.label,
        tooltip: column.tooltip,
        numeric: column.numeric,
        onSort: () => column.onSort(dataColumnIndex, sortColumnIndex == dataColumnIndex ? !sortAscending : true),
        sorted: dataColumnIndex == sortColumnIndex,
        ascending: sortAscending,
      );
      rowIndex = 1;
      for (DataRow row in rows) {
        final DataCell cell = row.cells[dataColumnIndex];
        tableRows[rowIndex].children[displayColumnIndex] = _buildDataCell(
          context: context,
          padding: padding,
          label: cell.child,
          numeric: column.numeric,
          placeholder: cell.placeholder,
          showEditIcon: cell.showEditIcon,
          onTap: cell.onTap,
          onSelectChanged: () => row.onSelectChanged(!row.selected),
        );
        rowIndex += 1;
      }
      displayColumnIndex += 1;
    }

    return Table(
      columnWidths: tableColumns.asMap(),
      children: tableRows,
    );
  }
}


class _SortArrow extends StatefulWidget {
  const _SortArrow({
    Key key,
    this.visible,
    this.down,
    this.duration,
  }) : super(key: key);

  final bool visible;

  final bool down;

  final Duration duration;

  @override
  _SortArrowState createState() => _SortArrowState();
}

class _SortArrowState extends State<_SortArrow> with TickerProviderStateMixin {

  AnimationController _opacityController;
  Animation<double> _opacityAnimation;

  AnimationController _orientationController;
  Animation<double> _orientationAnimation;
  double _orientationOffset = 0.0;

  bool _down;

  static final Animatable<double> _turnTween = Tween<double>(begin: 0.0, end: math.pi)
    .chain(CurveTween(curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    _opacityAnimation = CurvedAnimation(
      parent: _opacityController = AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
      curve: Curves.fastOutSlowIn
    )
    ..addListener(_rebuild);
    _opacityController.value = widget.visible ? 1.0 : 0.0;
    _orientationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _orientationAnimation = _orientationController.drive(_turnTween)
      ..addListener(_rebuild)
      ..addStatusListener(_resetOrientationAnimation);
    if (widget.visible)
      _orientationOffset = widget.down ? 0.0 : math.pi;
  }

  void _rebuild() {
    setState(() {
      // The animations changed, so we need to rebuild.
    });
  }

  void _resetOrientationAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      assert(_orientationAnimation.value == math.pi);
      _orientationOffset += math.pi;
      _orientationController.value = 0.0; // TODO(ianh): This triggers a pointless rebuild.
    }
  }

  @override
  void didUpdateWidget(_SortArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool skipArrow = false;
    final bool newDown = widget.down != null ? widget.down : _down;
    if (oldWidget.visible != widget.visible) {
      if (widget.visible && (_opacityController.status == AnimationStatus.dismissed)) {
        _orientationController.stop();
        _orientationController.value = 0.0;
        _orientationOffset = newDown ? 0.0 : math.pi;
        skipArrow = true;
      }
      if (widget.visible) {
        _opacityController.forward();
      } else {
        _opacityController.reverse();
      }
    }
    if ((_down != newDown) && !skipArrow) {
      if (_orientationController.status == AnimationStatus.dismissed) {
        _orientationController.forward();
      } else {
        _orientationController.reverse();
      }
    }
    _down = newDown;
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _orientationController.dispose();
    super.dispose();
  }

  static const double _arrowIconBaselineOffset = -1.5;
  static const double _arrowIconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacityAnimation.value,
      child: Transform(
        transform: Matrix4.rotationZ(_orientationOffset + _orientationAnimation.value)
                             ..setTranslationRaw(0.0, _arrowIconBaselineOffset, 0.0),
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_downward,
          size: _arrowIconSize,
          color: (Theme.of(context).brightness == Brightness.light) ? Colors.black87 : Colors.white70,
        ),
      ),
    );
  }

}
