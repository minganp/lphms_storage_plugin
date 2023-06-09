import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../../utility/position_enum.dart';
import '../../utility/prov_enum.dart';
import '../../utility/record_prefix.dart';
//import 'package:lphms_storage_plugin/utility/position_enum.dart';
//import 'package:lphms_storage_plugin/utility/prov_enum.dart';
//import 'package:lphms_storage_plugin/utility/record_prefix.dart';

Widget disDropDown({String? prov,String? dis, required ValueChanged<String> onSelected}) {
  List<DropDownValueModel> districtList = [];
  int itemCnt = 0;
  for (var element in disLao) {
    if(prov == null){
      var disItem = DropDownValueModel(
          name: element['dis']!, value: element['dis']);
      itemCnt++;
      districtList.add(disItem);
    } else{
      if (element["pk"]!.substring(0, 6) == "${rPref[RecType.region]}#$prov") {
        var disItem = DropDownValueModel(
            name: element['dis']!,
            value: element['pk']);
        itemCnt++;
        districtList.add(disItem);
      }
      continue;
    }
  }

  return SizedBox(
      width: 200,
      child:Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child:DropDownTextField(
      dropDownItemCount: itemCnt,
      initialValue: dis,
      dropDownList: districtList,
      searchDecoration: const InputDecoration(
        hintText: "Input Region here",
      ),
      validator: (value){
        if(value == null){
          return "Required field";
        }else{
          return null;
        }
      },
    onChanged: (val){
      print("dis: ${val.value}");

      onSelected(val.value);
    },
  )));
}

Widget provDropDown({String? prov,required ValueChanged<String> onSelected}){
  const itemCnt = 18;
  List<DropDownValueModel> provList = [];
  for (var element in province) {
    var provItem = DropDownValueModel(
        name: element["prov"]!,
        value: element["pk"]);
    provList.add(provItem);
  }
  return SizedBox(
      width: 200,
      child:Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child:DropDownTextField(
        initialValue: prov,
      dropDownList: provList,
      dropDownItemCount: itemCnt,
    onChanged: (val){
        onSelected(val.value);
    },
  )));
}