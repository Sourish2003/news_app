import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingComponent {
  showLoadingIndicator() {
    return EasyLoading.show();
  }

  dismissLoadingIndicator() {
    EasyLoading.dismiss();
  }
}
