/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the LHMS type in your schema. */
@immutable
class LHMS extends Model {
  static const classType = const _LHMSModelType();
  final String id;
  final String? _PK;
  final String? _SK;
  final String? _GSI1;
  final String? _sna;
  final String? _gna;
  final String? _isr;
  final TemporalDate? _dob;
  final String? _sex;
  final String? _iUr;
  final TemporalDate? _doe;
  final String? _ctc;
  final int? _avl;
  final int? _nor;
  final double? _lat;
  final double? _lon;
  final String? _addr;
  final String? _rno;
  final String? _hsi;
  final String? _hso;
  final String? _nna;
  final String? _prov;
  final String? _dis;
  final String? _hna;
  final int? _ihs;
  final String? _hsp;
  final String? _clg;
  final String? _tst;
  final TemporalDateTime? _cid;
  final int? _hsa;
  final TemporalDateTime? _cod;
  final String? _mph;
  final String? _cac;
  final List<String?>? _hnl; //hotel name list
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  LHMSModelIdentifier get modelIdentifier {
      return LHMSModelIdentifier(
        keys:{'PK': PK,
        'SK': SK,}
      );
  }
  
  String get PK {
    try {
      return _PK!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get SK {
    try {
      return _SK!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }

  String? get GSI1 {
    return _GSI1;
  }
  
  String? get sna {
    return _sna;
  }
  
  String? get gna {
    return _gna;
  }
  
  String? get isr {
    return _isr;
  }

  TemporalDate? get dob {
    return _dob;
  }
  
  String? get sex {
    return _sex;
  }
  
  String? get iUr {
    return _iUr;
  }
  
  TemporalDate? get doe {
    return _doe;
  }
  
  String? get ctc {
    return _ctc;
  }
  
  int? get avl {
    return _avl;
  }
  
  int? get nor {
    return _nor;
  }
  
  double? get lat {
    return _lat;
  }
  
  double? get lon {
    return _lon;
  }
  
  String? get addr {
    return _addr;
  }
  
  String? get rno {
    return _rno;
  }
  
  String? get hsi {
    return _hsi;
  }
  
  String? get hso {
    return _hso;
  }
  
  String? get nna {
    return _nna;
  }
  
  String? get prov {
    return _prov;
  }
  
  String? get dis {
    return _dis;
  }
  
  String? get hna {
    return _hna;
  }
  
  int? get ihs {
    return _ihs;
  }
  
  String? get hsp {
    return _hsp;
  }
  
  String? get clg {
    return _clg;
  }
  
  String? get tst {
    return _tst;
  }
  
  TemporalDateTime? get cid {
    return _cid;
  }
  
  int? get hsa {
    return _hsa;
  }
  
  TemporalDateTime? get cod {
    return _cod;
  }
  
  String? get mph {
    return _mph;
  }
  
  String? get cac {
    return _cac;
  }

  List<String?>? get hnl {
    return _hnl;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const LHMS._internal({required this.id, required PK, required SK, GSI1, sna, gna, isr, dob, sex, iUr, doe, ctc, avl, nor, lat, lon, addr, rno, hsi, hso, nna, prov, dis, hna, ihs, hsp, clg, tst, cid, hsa, cod, mph, cac, hnl,createdAt, updatedAt}): _PK = PK, _SK = SK, _GSI1 = GSI1, _sna = sna, _gna = gna, _isr = isr, _dob = dob, _sex = sex, _iUr = iUr, _doe = doe, _ctc = ctc, _avl = avl, _nor = nor, _lat = lat, _lon = lon, _addr = addr, _rno = rno, _hsi = hsi, _hso = hso, _nna = nna, _prov = prov, _dis = dis, _hna = hna, _ihs = ihs, _hsp = hsp, _clg = clg, _tst = tst, _cid = cid, _hsa = hsa, _cod = cod, _mph = mph,_hnl = hnl, _cac = cac, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory LHMS({String? id, required String PK, required String SK, String? GSI1, String? sna, String? gna, String? isr, TemporalDate? dob, String? sex, String? iUr, TemporalDate? doe, String? ctc, int? avl, int? nor, double? lat, double? lon, String? addr, String? rno, String? hsi, String? hso, String? nna, String? prov, String? dis, String? hna, int? ihs, String? hsp, String? clg, String? tst, TemporalDateTime? cid, int? hsa, TemporalDateTime? cod, String? mph, String? cac, List<String?>? hnl}) {
    return LHMS._internal(
      id: id == null ? UUID.getUUID() : id,
      PK: PK,
      SK: SK,
      GSI1: GSI1,
      sna: sna,
      gna: gna,
      isr: isr,
      dob: dob,
      sex: sex,
      iUr: iUr,
      doe: doe,
      ctc: ctc,
      avl: avl,
      nor: nor,
      lat: lat,
      lon: lon,
      addr: addr,
      rno: rno,
      hsi: hsi,
      hso: hso,
      nna: nna,
      prov: prov,
      dis: dis,
      hna: hna,
      ihs: ihs,
      hsp: hsp,
      clg: clg,
      tst: tst,
      cid: cid,
      hsa: hsa,
      cod: cod,
      mph: mph,
      cac: cac);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LHMS &&
      id == other.id &&
      _PK == other._PK &&
      _SK == other._SK &&
      _GSI1 == other._GSI1 &&
      _sna == other._sna &&
      _gna == other._gna &&
      _isr == other._isr &&
      _dob == other._dob &&
      _sex == other._sex &&
      _iUr == other._iUr &&
      _doe == other._doe &&
      _ctc == other._ctc &&
      _avl == other._avl &&
      _nor == other._nor &&
      _lat == other._lat &&
      _lon == other._lon &&
      _addr == other._addr &&
      _rno == other._rno &&
      _hsi == other._hsi &&
      _hso == other._hso &&
      _nna == other._nna &&
      _prov == other._prov &&
      _dis == other._dis &&
      _hna == other._hna &&
      _ihs == other._ihs &&
      _hsp == other._hsp &&
      _clg == other._clg &&
      _tst == other._tst &&
      _cid == other._cid &&
      _hsa == other._hsa &&
      _cod == other._cod &&
      _mph == other._mph &&
      _cac == other._cac;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("LHMS {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("PK=" + "$_PK" + ", ");
    buffer.write("SK=" + "$_SK" + ", ");
    buffer.write("GSI1=" + "$_GSI1" + ", ");
    buffer.write("sna=" + "$_sna" + ", ");
    buffer.write("gna=" + "$_gna" + ", ");
    buffer.write("isr=" + "$_isr" + ", ");
    buffer.write("dob=" + (_dob != null ? _dob!.format() : "null") + ", ");
    buffer.write("sex=" + "$_sex" + ", ");
    buffer.write("iUr=" + "$_iUr" + ", ");
    buffer.write("doe=" + (_doe != null ? _doe!.format() : "null") + ", ");
    buffer.write("ctc=" + "$_ctc" + ", ");
    buffer.write("avl=" + (_avl != null ? _avl!.toString() : "null") + ", ");
    buffer.write("nor=" + (_nor != null ? _nor!.toString() : "null") + ", ");
    buffer.write("lat=" + (_lat != null ? _lat!.toString() : "null") + ", ");
    buffer.write("lon=" + (_lon != null ? _lon!.toString() : "null") + ", ");
    buffer.write("addr=" + "$_addr" + ", ");
    buffer.write("rno=" + "$_rno" + ", ");
    buffer.write("hsi=" + "$_hsi" + ", ");
    buffer.write("hso=" + "$_hso" + ", ");
    buffer.write("nna=" + "$_nna" + ", ");
    buffer.write("prov=" + "$_prov" + ", ");
    buffer.write("dis=" + "$_dis" + ", ");
    buffer.write("hna=" + "$_hna" + ", ");
    buffer.write("ihs=" + (_ihs != null ? _ihs!.toString() : "null") + ", ");
    buffer.write("hsp=" + "$_hsp" + ", ");
    buffer.write("clg=" + "$_clg" + ", ");
    buffer.write("tst=" + "$_tst" + ", ");
    buffer.write("cid=" + (_cid != null ? _cid!.format() : "null") + ", ");
    buffer.write("hsa=" + (_hsa != null ? _hsa!.toString() : "null") + ", ");
    buffer.write("cod=" + (_cod != null ? _cod!.format() : "null") + ", ");
    buffer.write("mph=" + "$_mph" + ", ");
    buffer.write("cac=" + "$_cac" + ", ");
    buffer.write("hnl=" + (_hnl != null ? _hnl!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  LHMS copyWith({String? PK, String? SK, String? GSI1, String? sna, String? gna, String? isr, TemporalDate? dob, String? sex, String? iUr, TemporalDate? doe, String? ctc, int? avl, int? nor, double? lat, double? lon, String? addr, String? rno, String? hsi, String? hso, String? nna, String? prov, String? dis, String? hna, int? ihs, String? hsp, String? clg, String? tst, TemporalDateTime? cid, int? hsa, TemporalDateTime? cod, String? mph, String? cac, List<String?>? hnl}) {
    return LHMS._internal(
      id: id,
      PK: PK ?? this.PK,
      SK: SK ?? this.SK,
      GSI1: GSI1 ?? this.GSI1,
      sna: sna ?? this.sna,
      gna: gna ?? this.gna,
      isr: isr ?? this.isr,
      dob: dob ?? this.dob,
      sex: sex ?? this.sex,
      iUr: iUr ?? this.iUr,
      doe: doe ?? this.doe,
      ctc: ctc ?? this.ctc,
      avl: avl ?? this.avl,
      nor: nor ?? this.nor,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      addr: addr ?? this.addr,
      rno: rno ?? this.rno,
      hsi: hsi ?? this.hsi,
      hso: hso ?? this.hso,
      nna: nna ?? this.nna,
      prov: prov ?? this.prov,
      dis: dis ?? this.dis,
      hna: hna ?? this.hna,
      ihs: ihs ?? this.ihs,
      hsp: hsp ?? this.hsp,
      clg: clg ?? this.clg,
      tst: tst ?? this.tst,
      cid: cid ?? this.cid,
      hsa: hsa ?? this.hsa,
      cod: cod ?? this.cod,
      mph: mph ?? this.mph,
      hnl: hnl ?? this.hnl,
      cac: cac ?? this.cac);

  }
  
  LHMS.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _PK = json['PK'],
      _SK = json['SK'],
      _GSI1 = json['GSI1'],
      _sna = json['sna'],
      _gna = json['gna'],
      _isr = json['isr'],
      _dob = json['dob'] != null ? TemporalDate.fromString(json['dob']) : null,
      _sex = json['sex'],
      _iUr = json['iUr'],
      _doe = json['doe'] != null ? TemporalDate.fromString(json['doe']) : null,
      _ctc = json['ctc'],
      _avl = (json['avl'] as num?)?.toInt(),
      _nor = (json['nor'] as num?)?.toInt(),
      _lat = (json['lat'] as num?)?.toDouble(),
      _lon = (json['lon'] as num?)?.toDouble(),
      _addr = json['addr'],
      _rno = json['rno'],
      _hsi = json['hsi'],
      _hso = json['hso'],
      _nna = json['nna'],
      _prov = json['prov'],
      _dis = json['dis'],
      _hna = json['hna'],
      _ihs = (json['ihs'] as num?)?.toInt(),
      _hsp = json['hsp'],
      _clg = json['clg'],
      _tst = json['tst'],
      _cid = json['cid'] != null ? TemporalDateTime.fromString(json['cid']) : null,
      _hsa = (json['hsa'] as num?)?.toInt(),
      _cod = json['cod'] != null ? TemporalDateTime.fromString(json['cod']) : null,
      _mph = json['mph'],
      _cac = json['cac'],
      _hnl = json['hnl'] as List<String?>?,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() {
    Map<String,dynamic> json = {};
    json = {'id': id, 'PK': _PK, 'SK': _SK, 'GSI1': _GSI1, 'sna': _sna, 'gna': _gna, 'isr': _isr, 'dob': _dob?.format(), 'sex': _sex, 'iUr': _iUr, 'doe': _doe?.format(), 'ctc': _ctc, 'avl': _avl, 'nor': _nor, 'lat': _lat, 'lon': _lon, 'addr': _addr, 'rno': _rno, 'hsi': _hsi, 'hso': _hso, 'nna': _nna, 'prov': _prov, 'dis': _dis, 'hna': _hna, 'ihs': _ihs, 'hsp': _hsp, 'clg': _clg, 'tst': _tst, 'cid': _cid?.format(), 'hsa': _hsa, 'cod': _cod?.format(), 'mph': _mph, 'cac': _cac, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()};
    json.removeWhere((key, value) => value==null);

    return json;
  }


  Map<String, Object?> toMap() => {
    'id': id, 'PK': _PK, 'SK': _SK, 'GSI1': _GSI1, 'sna': _sna, 'gna': _gna, 'isr': _isr, 'dob': _dob, 'sex': _sex, 'iUr': _iUr, 'doe': _doe, 'ctc': _ctc, 'avl': _avl, 'nor': _nor, 'lat': _lat, 'lon': _lon, 'addr': _addr, 'rno': _rno, 'hsi': _hsi, 'hso': _hso, 'nna': _nna, 'prov': _prov, 'dis': _dis, 'hna': _hna, 'ihs': _ihs, 'hsp': _hsp, 'clg': _clg, 'tst': _tst, 'cid': _cid, 'hsa': _hsa, 'cod': _cod, 'mph': _mph, 'cac': _cac, 'hnl':_hnl,'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<LHMSModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<LHMSModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField QPK = QueryField(fieldName: "PK");
  static final QueryField QSK = QueryField(fieldName: "SK");
  static final QueryField QGSI1 = QueryField(fieldName: "GSI1");
  static final QueryField SNA = QueryField(fieldName: "sna");
  static final QueryField GNA = QueryField(fieldName: "gna");
  static final QueryField ISR = QueryField(fieldName: "isr");
  static final QueryField DOB = QueryField(fieldName: "dob");
  static final QueryField SEX = QueryField(fieldName: "sex");
  static final QueryField IUR = QueryField(fieldName: "iUr");
  static final QueryField DOE = QueryField(fieldName: "doe");
  static final QueryField CTC = QueryField(fieldName: "ctc");
  static final QueryField AVL = QueryField(fieldName: "avl");
  static final QueryField NOR = QueryField(fieldName: "nor");
  static final QueryField LAT = QueryField(fieldName: "lat");
  static final QueryField LON = QueryField(fieldName: "lon");
  static final QueryField ADDR = QueryField(fieldName: "addr");
  static final QueryField RNO = QueryField(fieldName: "rno");
  static final QueryField HSI = QueryField(fieldName: "hsi");
  static final QueryField HSO = QueryField(fieldName: "hso");
  static final QueryField NNA = QueryField(fieldName: "nna");
  static final QueryField PROV = QueryField(fieldName: "prov");
  static final QueryField DIS = QueryField(fieldName: "dis");
  static final QueryField HNA = QueryField(fieldName: "hna");
  static final QueryField IHS = QueryField(fieldName: "ihs");
  static final QueryField HSP = QueryField(fieldName: "hsp");
  static final QueryField CLG = QueryField(fieldName: "clg");
  static final QueryField TST = QueryField(fieldName: "tst");
  static final QueryField CID = QueryField(fieldName: "cid");
  static final QueryField HSA = QueryField(fieldName: "hsa");
  static final QueryField COD = QueryField(fieldName: "cod");
  static final QueryField MPH = QueryField(fieldName: "mph");
  static final QueryField CAC = QueryField(fieldName: "cac");
  static final QueryField HNL = QueryField(fieldName: "hnl");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "LHMS";
    modelSchemaDefinition.pluralName = "LHMS";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: const [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["GSI1"], name: null),
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.QPK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.QSK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.QGSI1,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.SNA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.GNA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.ISR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.DOB,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date),

    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.SEX,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.IUR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.DOE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.CTC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.AVL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.NOR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.LAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.LON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.ADDR,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.RNO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.HSI,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.HSO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.NNA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.PROV,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.DIS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.HNA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.IHS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.HSP,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.CLG,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.TST,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.CID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.HSA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.COD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.MPH,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: LHMS.CAC,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: LHMS.HNL,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _LHMSModelType extends ModelType<LHMS> {
  const _LHMSModelType();
  
  @override
  LHMS fromJson(Map<String, dynamic> jsonData) {
    return LHMS.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'LHMS';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [LHMS] in your schema.
 */
@immutable
class LHMSModelIdentifier implements ModelIdentifier<LHMS> {
  final Map<String,String>? keys;// = <String,String>{'PK': '','SK': ''};
  //final String? PK;
  //final String? SK;
  /** Create an instance of LHMSModelIdentifier using [id] the primary key. */
  const LHMSModelIdentifier({
    required this.keys
    /*required this.PK,required this.SK*/});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'keys': keys,
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'LHMSModelIdentifier(keys: $keys})';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is LHMSModelIdentifier &&
      keys == other.keys ;
  }
  
  @override
  int get hashCode =>
    keys.hashCode ;
}