library instance;

import 'package:base_bloc_project/base_bloc_project.dart';

extension Inst on Interface {
  static final Map<String, _InstanceBuilderFactory> _singleton = {};

  S find<S>({String? tag}) {
    final key = _getKey(S, tag);
    if (isRegistered<S>(tag: tag)) {
      final dep = _singleton[key];
      if (dep == null) {
        throw 'Class "$S" with tag "$tag" is not registered';
      }
      return dep.getDependency();
    } else {
      throw '"$S" not found. You need to call "Get.put($S())" or "Get.lazyPut(()=>$S())"';
    }
  }

  S put<S>({
    required S dependency,
    String? tag,
  }) {
    _insert(tag: tag, builder: () => dependency);
    return find<S>(tag: tag);
  }

  bool delete<S>({String? tag, String? key}) {
    assert((tag ?? key) != null);
    final newKey = key ?? _getKey(S, tag);
    if (!_singleton.containsKey(newKey)) {
      Get.log('Instance "$newKey" already removed.', isError: true);
      return false;
    } else {
      _singleton.remove(newKey);
      return true;
    }
  }

  bool isRegistered<S>({String? tag}) =>
      _singleton.containsKey(_getKey(S, tag));

  void _insert<S>({
    required String? tag,
    required InstanceBuilderCallback<S> builder,
  }) {
    final key = _getKey(S, tag);
    _singleton[key] = _InstanceBuilderFactory<S>(
      builderFunc: builder,
      tag: tag,
    );
  }

  String _getKey(Type type, String? tag) {
    return tag == null ? type.hashCode.toString() : '${type.toString()}__$tag';
  }
}

typedef InstanceBuilderCallback<S> = S Function();

class _InstanceBuilderFactory<S> extends Object {
  S? dependency;
  InstanceBuilderCallback<S> builderFunc;
  String? tag;

  _InstanceBuilderFactory({
    required this.builderFunc,
    required this.tag,
  });

  S getDependency() {
    if (dependency == null) {
      Get.log('Instance "$S" has been created with tag "$tag"');
      dependency = builderFunc();
    }
    return dependency!;
  }
}
