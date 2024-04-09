

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:maids_project/core/error/base_error.dart';
import 'package:maids_project/core/error/connection/net_error.dart';
import 'package:maids_project/core/param/base_param.dart';
import 'package:maids_project/core/result/result.dart';
import 'package:maids_project/data/models/user.dart';

import 'package:maids_project/presentation/custom_widgets/infinite_list_view/bloc/infinite_list_bloc.dart';
import 'package:maids_project/presentation/custom_widgets/infinite_list_view/entity/pagination_params.dart';
import 'package:maids_project/presentation/custom_widgets/infinite_list_view/entity/task_wrappers.dart';

import 'package:maids_project/presentation/custom_widgets/infinite_list_view/presentation/pagination_builder.dart';


typedef AsyncCallbackWithParams<T> = Future<T> Function(BaseParams b);
typedef BuilderType<T> = Widget Function(T data, int index);

class WrapperParams {
  final int startIndex;
  final Map<String, dynamic> extraParams;

  WrapperParams(this.startIndex, this.extraParams);

  WrapperParams copyWith({int? startIndex, Map<String, dynamic>? extraParams}) {
    return PaginationParams(
        startIndex: startIndex ?? this.startIndex, extraParams: extraParams ?? this.extraParams);
  }
}

abstract class UseCaseWrapper<T, P extends WrapperParams> {
  Future<List<T>> caller(P params);

  Future<List<T>> responseChecker(Result<BaseError, List<T>> response) async {
   // print('response.hasDataOnly: ${response.hasDataOnly}');

    if (response.hasDataOnly) {
      print('response.hasDataOnly: ${response.data}');
      return response.data??[];
    } else if (response.hasErrorOnly) {
      print("type error ${response.error is NetError }");
      throw Exception(response.error);
    }
    return [];
  }
}

extension PainationUseCaseBuilder on UseCaseWrapper {
  Widget buildPaginationList<T>({
    Map<String, dynamic>? extraParams,
    BuilderType<T>? listBuilder,
    BuilderType<T>? gridBuilder,
    EdgeInsets? padding,
    Key? builderKey,
    PaginationController<T>? controller,
     CarouselOptions? options,
    ScrollController? scrollController,
    void Function(int id, int index, bool hasChild)? onPressed,
    int? currentId,
    ListType? type,
  }) {
    print('asdasdasdsdsadasdasdsad');
    switch (runtimeType) {
      case GetTask:
        return _buildTaskList(
            builderKey,
            extraParams??{},
            listBuilder as BuilderType<User>,
            gridBuilder as BuilderType<User>,
            controller as PaginationController<User>,options);

      default:
        return Container();
    }
  }
}




extension Builders on UseCaseWrapper {
  Widget _buildTaskList(
      Key? builderKey,
      Map<String, dynamic> extraParams,
      BuilderType<User> listBuilder,
      BuilderType<User> gridBuilder,

      PaginationController<User>? controller,CarouselOptions? options,
     ) {
    return PaginationBuilder<User>(
      key: builderKey,
      type: ListType.list,
      scrollDirection: Axis.vertical,
      flex: 10,
      controller: controller,
      extraParams: extraParams,
      useCase: this,
      listBuilder: listBuilder,
      gridBuilder: gridBuilder,
      options: options,

    );
  }

}
