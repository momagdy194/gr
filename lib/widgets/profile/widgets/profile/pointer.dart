  import 'dart:convert';
  
  import 'package:flutter/cupertino.dart';
  /// Flutter package imports
  import 'package:flutter/material.dart';
  
  /// Gauge imports
  import 'package:syncfusion_flutter_gauges/gauges.dart';
  import 'package:http/http.dart' as http;
  
  class Pointer extends StatefulWidget {
    final String companyName;
  
    Pointer({this.companyName});
  
    @override
    _PointerState createState() => _PointerState();
  }
  
  class _PointerState extends State<Pointer> {
    _PointerState();
  
    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Here you can get stock prediction',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          widget.companyName != "F"
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  color: Colors.red,
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Text(
                    "We are Sorry the prediction  Will Come  soon",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  )))
              : Container(
                  child: _buildRadialTextPointer(widget.companyName)),
  
  
         ],
      );
    }
  
    _buildRadialTextPointer(companyName) {
      return FutureBuilder(
        future: feachMoney(companyName),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
  
            PreModel val=snapshot.data;
  print(val.decision);
            return Column(
              children: [
                Container( height: 150,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                          showAxisLine: false,
                          showLabels: false,
                          showTicks: false,
                          startAngle: 180,
                          endAngle: 360,
                          minimum: 0,
                          maximum: 10 ,
                          canScaleToFit: true,
                          radiusFactor: 0.79,
                          pointers: <GaugePointer>[
                            NeedlePointer(
                                needleStartWidth: 1,
                                lengthUnit: GaugeSizeUnit.factor,
                                needleEndWidth: 5,
                                needleLength: 0.7,
                                value:val.decision,
                                knobStyle: KnobStyle(knobRadius: 0)),
                          ],
                          ranges: <GaugeRange>[
                            GaugeRange(
                                startWidth: 0.45,
                                endWidth: 0.45,
                                sizeUnit: GaugeSizeUnit.factor,
                                startValue: 0,
                                endValue: 4,
                                color: const Color(0xFFDD3800)),
                            GaugeRange(
                                startWidth: 0.45,
                                sizeUnit: GaugeSizeUnit.factor,
                                endWidth: 0.45,
                                startValue: 4.04,
                                endValue: 6,
                                color: const Color(0xFFFFBA00)),
                            GaugeRange(
                                sizeUnit: GaugeSizeUnit.factor,
                                startWidth: 0.45,
                                endWidth: 0.45,
                                startValue: 6.04,
                                endValue: 10,
                                color: const Color(0xFF8BE724)),
                          ]),
                      RadialAxis(
                        showAxisLine: false,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 180,
                        endAngle: 360,
                        minimum: 0,
                        maximum: 120,
                        radiusFactor: 0.85,
                        canScaleToFit: true,
                        pointers: <GaugePointer>[
                          MarkerPointer(
                              markerType: MarkerType.text,
                              text: 'sell',
                              value: 20.5,
                              textStyle: GaugeTextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Times'),
                              offsetUnit: GaugeSizeUnit.factor,
                              markerOffset: -0.12),
                          MarkerPointer(
                              markerType: MarkerType.text,
                              text: 'neutral',
                              value: 60.5,
                              textStyle: GaugeTextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Times'),
                              offsetUnit: GaugeSizeUnit.factor,
                              markerOffset: -0.12),
                          MarkerPointer(
                              markerType: MarkerType.text,
                              text: 'buy',
                              value: 100.5,
                              textStyle: GaugeTextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Times'),
                              offsetUnit: GaugeSizeUnit.factor,
                              markerOffset: -0.12)
                        ],
                      ),
                    ],
                  ),
                ),
  
            Text(val.decision.toString()),
            SizedBox(height: 5,),
            if(val.decision>=0&&val.decision<=4)
              Text("Sell",style: TextStyle(color:  Color(0xFFDD3800)),)
  
                else if(val.decision>4&&val.decision<=6)
              Text("Natural",style: TextStyle(color: Color(0xFFFFBA00)),)
           else if(val.decision>4&&val.decision<=6)
              Text("buy",style:  TextStyle(color: Color(0xFF8BE724)),)
  
  
              ],
            );
          }
          return Container(
            height: 150,
            child: Stack(
              children: [
                SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                        showAxisLine: false,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 180,
                        endAngle: 360,
                        minimum: 0,
                        maximum: 10,
                        canScaleToFit: true,
                        radiusFactor: 0.79,
                        pointers: <GaugePointer>[
                          NeedlePointer(
                              needleStartWidth: 1,
                              lengthUnit: GaugeSizeUnit.factor,
                              needleEndWidth: 5,
                              needleLength: 0.7,
                              value: 0,
                              knobStyle: KnobStyle(knobRadius: 0)),
                        ],
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startWidth: 0.45,
                              endWidth: 0.45,
                              sizeUnit: GaugeSizeUnit.factor,
                              startValue: 0,
                              endValue: 4,
                              color: const Color(0xFFDD3800)),
                          GaugeRange(
                              startWidth: 0.45,
                              sizeUnit: GaugeSizeUnit.factor,
                              endWidth: 0.45,
                              startValue: 4.04,
                              endValue: 6,
                              color: const Color(0xFFFFBA00)),
                          GaugeRange(
                              sizeUnit: GaugeSizeUnit.factor,
                              startWidth: 0.45,
                              endWidth: 0.45,
                              startValue: 6.04,
                              endValue: 10,
                              color: const Color(0xFF8BE724)),
                        ]),
                    RadialAxis(
                      showAxisLine: false,
                      showLabels: false,
                      showTicks: false,
                      startAngle: 180,
                      endAngle: 360,
                      minimum: 0,
                      maximum: 120,
                      radiusFactor: 0.85,
                      canScaleToFit: true,
                      pointers: <GaugePointer>[
                        MarkerPointer(
                            markerType: MarkerType.text,
                            text: 'sell',
                            value: 20.5,
                            textStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Times'),
                            offsetUnit: GaugeSizeUnit.factor,
                            markerOffset: -0.12),
                        MarkerPointer(
                            markerType: MarkerType.text,
                            text: 'neutral',
                            value: 60.5,
                            textStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Times'),
                            offsetUnit: GaugeSizeUnit.factor,
                            markerOffset: -0.12),
                        MarkerPointer(
                            markerType: MarkerType.text,
                            text: 'buy',
                            value: 100.5,
                            textStyle: GaugeTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Times'),
                            offsetUnit: GaugeSizeUnit.factor,
                            markerOffset: -0.12)
                      ],
                    ),
                  ],
                ),
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          );
        },
      );
    }
  }
  
  Future<PreModel> feachMoney(name) async {
    print(name);
    String url = "http://3ee0a8c030b0.ngrok.io/predict?data=F";
    http.Response response = await http.post(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
       return PreModel.fromJson(json.decode(response.body));
    } else {
      throw "It doseNot Work";
    }
  }
  
  
  class PreModel {
    double decision;
  
    PreModel({this.decision});
  
    PreModel.fromJson(Map<String, dynamic> json) {
      decision = json['Decision'];
    }
  
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['Decision'] = this.decision;
      return data;
    }
  }