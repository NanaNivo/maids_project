

import 'package:maids_project/core/helper/mappers/base_mapper.dart';
import 'package:maids_project/data/datasources/local_data_source/database.dart';
import 'package:maids_project/data/models/user.dart';

class TaskItemModelMapper extends Mapper<TaskItem, User> {
  @override
  User map(TaskItem object) {
    return User(
      id:object.id,
      firstName: object.name,
      job: object.description
    );
  }

  @override
  TaskItem unmap(User object) {
    return TaskItem(
       name: object.firstName??'',
        description: object.email??"",
        id: object.id??0);
  }
}

class TaskItemDataBaseMapper extends Mapper<User, TaskItemsCompanion> {
  @override
  TaskItemsCompanion map(User object) {
    return TaskItemsCompanion.insert(
      //   id: Value(object.id),
        name: object.firstName??'',
        description: object.email??'',

      );
  }
}

// class CartItemEntityMapper extends Mapper<TaskItemEntity, User> {
//   @override
//   CartItemModel map(CartItemEntity object) {
//     return CartItemModel(
//       object.id,
//       object.productId,
//       object.specificationId,
//       object.quantity,
//       object.name,
//       object.image,
//     );
//   }
//
//   @override
//   CartItemEntity unmap(CartItemModel object) {
//     return CartItemEntity(
//       object.id,
//       productId: object.productId,
//       specificationId: object.specificationId,
//       quantity: object.quantity,
//       name: object.name,
//       image: object.image,
//     );
//   }
// }
