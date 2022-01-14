import 'package:finances/models/accounts.dart';
import 'package:finances/models/category.dart';
import 'package:finances/models/records.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecordsList extends StatefulWidget {
  RecordsList({Key? key}) : super(key: key);

  @override
  _RecordsListState createState() => _RecordsListState();
}

class _RecordsListState extends State<RecordsList> {
  List<Record> data = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRecords(),
      builder: (context, snapshoot){
        if (snapshoot.hasError || !snapshoot.hasData){
          return SizedBox();
        }
        data = (snapshoot.data as List<Record>);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index){
            return InkWell(onTap: () {}, 
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getIconAndNameCategory(data[index]),
                      _getValueAndDate(data[index]),
                    ],
                  ),
                ),
            );
          });
      });   
  }

  FutureBuilder _getIconAndNameCategory(Record data) {
    final space = SizedBox(width: 6.w,);
    return FutureBuilder(
      future: getCategoryByID(data.category),
      builder: (context, snapshoot){
        if (snapshoot.hasData){
          Category categoryResponse =  snapshoot.data as Category;
          return Row(
            children: [
              _getIcon(categoryResponse, data.type),
                space,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(categoryResponse.name, 
                    style: const TextStyle(fontWeight: FontWeight.bold),),
                  _getAccount(data.accountOrigin),
                  Text(data.description, overflow: TextOverflow.ellipsis),
                ],
              )
            ],
          );
        }
        return Row(
          children:  [
            CircleAvatar(
              backgroundColor: colorsRecord[data.type],
              child:
              const Icon(
                Icons.compare_arrows,
                color: Colors.white,
                size: 30,)),
            space,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Transacción", style: TextStyle(fontWeight: FontWeight.bold)),
                _getAccount(data.accountOrigin),
                Text(data.description, overflow: TextOverflow.ellipsis,),
              ],
            )
          ],
        );
      });
  }

  Widget _getIcon(Category categoryResponse, String type) {
    return CircleAvatar(
            backgroundColor: colorsRecord[type],
            child: Icon(
                IconData(categoryResponse.icon, fontFamily: 'MaterialIcons'),
                color: Colors.white,
                size: 30,
              ),
    );
  }

  _getValueAndDate(Record data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("COP ${(data.value).toStringAsFixed(0)}", style: TextStyle(
          color: colorsRecord[data.type], overflow: TextOverflow.ellipsis
        ),),
        Text(data.date),
      ],
    );
  }

  FutureBuilder _getAccount(int? accountOrigin) {
    return FutureBuilder(
      future: getAccountById(accountOrigin),
      builder: (context, snapshoot){
        if (snapshoot.hasData){
          return Text((snapshoot.data as Account).name);
        }
        return const SizedBox();
      });
  }
}