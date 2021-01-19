import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:poli_notes/src/db/operationDB.dart';
import 'package:poli_notes/src/models/pill.dart';
import 'package:poli_notes/src/notifications/notifications.dart';

class MedicineCard extends StatelessWidget {
  final Pill medicine;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicineCard(
      this.medicine, this.setData, this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    //check if the medicine time is lower than actual
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > medicine.time;

    return Card(
        elevation: 2.0,
        margin: EdgeInsets.symmetric(vertical: 4.0),
        color: Colors.white,
        child: ListTile(
            onLongPress: () => _showDeleteDialog(
                context, medicine.name, medicine.id, medicine.notifyId),
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            title: Text(
              medicine.name,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.black,
                  fontSize: 18.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${medicine.amount}",
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${medicine.medicineForm}",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(medicine.time)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
            leading: Container(
              width: 40.0,
              height: 40.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(medicine.image)),
              ),
            )));
  }

  //--------------------------| SHOW THE DELETE DIALOG ON THE SCREEN |-----------------------

  void _showDeleteDialog(
      BuildContext context, String medicineName, int medicineId, int notifyId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Borrar"),
              content: Text("Estás seguto que deseas eliminar $medicineName?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text("Aceptar",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () async {
                    await OperationDB.deleteData('Pills', medicineId);
                    await Notifications().removeNotify(
                        notifyId, flutterLocalNotificationsPlugin);
                    setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
  //============================================================================================

}
