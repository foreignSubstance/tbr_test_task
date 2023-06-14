import 'package:flutter/material.dart';

class UpdateWidgetViewModel extends ChangeNotifier {
  int? currentPage;
  List<String> rocketsList = [];

  UpdateWidgetViewModel();

  void provideCurrentPage(int? pageNumber) {
    if (currentPage != pageNumber) {
      currentPage = pageNumber;
      notifyListeners();
    }
  }
}

class UpdateViewProvider extends InheritedNotifier<UpdateWidgetViewModel> {
  final UpdateWidgetViewModel model;

  const UpdateViewProvider(
      {Key? key, required this.model, required Widget child})
      : super(key: key, child: child, notifier: model);

  static UpdateWidgetViewModel? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UpdateViewProvider>()
        ?.model;
  }

  @override
  bool updateShouldNotify(UpdateViewProvider oldWidget) {
    return notifier != oldWidget.notifier;
  }
}
