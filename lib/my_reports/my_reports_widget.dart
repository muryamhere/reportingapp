import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_reports_model.dart';
export 'my_reports_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyReportsWidget extends StatefulWidget {
  const MyReportsWidget({Key? key}) : super(key: key);

  @override
  State<MyReportsWidget> createState() => _MyReportsWidgetState();
}

class _MyReportsWidgetState extends State<MyReportsWidget> {
  List<String> tables = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchTables() async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Reset error message before loading
    });

    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:5000/fetch_tables'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          tables = List<String>.from(
              data['tables']); // Ensure tables is of type List<String>
          isLoading = false;
        });
      } else {
        throw 'Failed to fetch tables: ${response.statusCode}';
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: $error';
        isLoading = false;
      });
    }
  }

  Future<void> fetchTableData(String tableName) async {
    setState(() {
      isLoading = true;
      errorMessage = ''; // Reset error message before loading
    });

    try {
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:5000/fetch_table_data?table_name=$tableName'),
      );
      if (response.statusCode == 200) {
        // Handle the response to display table data
        // For example, you can show it in a dialog or navigate to a new screen
        // based on your UI design
      } else {
        throw 'Failed to fetch table data: ${response.statusCode}';
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Error: $error';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tables'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : tables.isEmpty
                  ? Center(child: Text('No tables found'))
                  : ListView.builder(
                      itemCount: tables.length,
                      itemBuilder: (context, index) {
                        final tableName = tables[index];
                        return ListTile(
                          title: Text(tableName),
                          onTap: () {
                            // Fetch and display table data when table name is tapped
                            fetchTableData(tableName);
                          },
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchTables,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
