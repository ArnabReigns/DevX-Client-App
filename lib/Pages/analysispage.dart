import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skeletons/skeletons.dart';

class AnalysisPage extends StatefulWidget {
  final url;
  AnalysisPage({super.key, required this.url});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  Future fetchAnalysis() async {
    final response =
        await http.get(Uri.parse('${widget.url}?action=getAnalytics'));
    final data = await json.decode(response.body);
    print(data);
    return data;
  }

  Future fetchData() async {
    List dataarr = [];

    final response =
        await http.get(Uri.parse('${widget.url}?action=allParticipants'));
    if (response.statusCode == 200) {
      final data = await json.decode(response.body);
      dataarr = data
          .map((item) => [
                item['row'].toString(),
                item['name'],
                item['registration'].toString(),
                item['food'].toString(),
                item['swags'].toString()
              ])
          .toList();
      print(dataarr);
      return dataarr;
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }

    return dataarr;
  }

  @override
  void initState() {
    fetchAnalysis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: fetchAnalysis(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // show a loading indicator if data is not yet available
                return Container(
                    // color: Colors.black,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15.0),
                    // child: Center(child: CircularProgressIndicator()),
                    child: SkeletonAvatar());
              } else if (snapshot.hasError) {
                // show an error message if there was an error fetching data
                return Text('Error: ${snapshot.error}');
              } else {
                // show the data
                return Container(
                  decoration: BoxDecoration(color: Colors.blue[300]),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("REG"),
                          Text(snapshot.data['registration'].toString()),
                        ],
                      ),
                      Column(
                        children: [
                          Text("FOOD"),
                          Text(snapshot.data['food'].toString()),
                        ],
                      ),
                      Column(
                        children: [
                          Text("SWAGS"),
                          Text(snapshot.data['swags'].toString()),
                        ],
                      )
                    ],
                  ),
                );
              }
            })),
        SizedBox(height: 8),
        Expanded(
          child: FutureBuilder(
              future: fetchData(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // show a loading indicator if data is not yet available
                  return SkeletonListView();
                } else if (snapshot.hasError) {
                  // show an error message if there was an error fetching data
                  return Text('Error: ${snapshot.error}');
                } else {
                  // show the data
                  return MyTable(data: snapshot.data);
                }
              })),
        ),
      ],
    );
  }
}

class MyTable extends StatefulWidget {
  final List data;

  const MyTable({Key? key, required this.data}) : super(key: key);

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Row')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Reg')),
            DataColumn(label: Text('Food')),
            DataColumn(label: Text('Swag')),
          ],
          rows: widget.data.map((row) {
            return DataRow(
              cells: [
                DataCell(Text(row[0])),
                DataCell(Text(row[1])),
                DataCell(Text(row[2])),
                DataCell(Text(row[3])),
                DataCell(Text(row[4])),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
