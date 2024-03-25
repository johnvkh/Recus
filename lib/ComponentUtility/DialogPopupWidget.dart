import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future<Null> DialogSucessfull(BuildContext context, String title,
    String message, VoidCallback btnOkOnPress) async {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          width: 300,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          headerAnimationLoop: true,
          animType: AnimType.RIGHSLIDE,
          title: title,
          desc: message,
          btnOkOnPress: btnOkOnPress,
          btnOkColor: Colors.red,
          btnOkText: "Continue")
      .show();
}

Future<Null> DialogConfirm(
  BuildContext context,
  String title,
  String message,
  VoidCallback btnOkOnPress,
) async {
  AwesomeDialog(
    width: MediaQuery.of(context).size.width * 0.4,
    context: context,
    dialogType: DialogType.warning,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title,
    desc: message,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnCancelOnPress: () {
      Navigator.pop(context);
    },
    btnOkOnPress: btnOkOnPress,
  ).show();
}

Future<Null> DialogFail(
  BuildContext context,
  String title,
  String message,
) async {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          width: 300,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          headerAnimationLoop: true,
          animType: AnimType.RIGHSLIDE,
          title: title,
          desc: message,
          btnOkOnPress: () {
            //Navigator.pop(context);
          },
          btnOkColor: Colors.red,
          btnOkText: "Continue")
      .show();
}

Future<Null> DialogFailConfirm(
  BuildContext context,
  String title,
  String message,
  VoidCallback btnOkOnPress,
) async {
  AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          width: 300,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          headerAnimationLoop: true,
          animType: AnimType.RIGHSLIDE,
          title: title,
          desc: message,
          btnOkOnPress: btnOkOnPress,
          btnCancelText: "ຍົກເລີກ",
          btnOkColor: Colors.red,
          btnOkText: "ຢືນຢັນ")
      .show();
}



Future<dynamic> buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 10,
        child: Container(
          width: 10,
          child: Row(
            children: [
              Lottie.asset("assets/lottie/loading.json",
                  width: 60, height: 60),
              SizedBox(width: 15),
              Text("ກຳລັງປະມວນຜົນ...."),
            ],
          ),
        ),
      );
    },
  );
}

Widget ShowDialog() {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 10,
        child: Container(
          width: 10,
          child: Row(
            children: [
              Lottie.asset("assets/lottie/loading.json",
                  width: 60, height: 60),
              SizedBox(width: 15),
              Text("ກຳລັງປະມວນຜົນ...."),
            ],
          ),
        ),
      );
}


class DialogBuilder {
  DialogBuilder(this.context);
  final BuildContext context;
  void showLoadingIndicator() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 10,
          child: Container(
            width: 10,
            child: Row(
              children: [
                Lottie.asset(
                    "assets/lottie/loading.json", width: 60, height: 60),
                SizedBox(width: 15),
                Text("ກຳລັງປະມວນຜົນ...."),
              ],
            ),
          ),
        );
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}
