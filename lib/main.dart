import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Dio dio = Dio();
  String url = 'https://fakestoreapi.com/products';
  List<dynamic> datamodel = [];


  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<dynamic>> getData() async {
    Response response = await dio.get(url);
    print(response.data);
    print(response.statusCode);
    datamodel = response.data.map((item) => datamodel.fromJson(item)).toList();
    return datamodel ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('fake store'),
        ),
        body: SafeArea(
            child: FutureBuilder(
              future: getData(),
              builder: ((context, snapshot) {
                return snapshot.hasData ? ListView.builder(
                  itemCount: datamodel.length,
                  itemBuilder: (context, index) {
                    return
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(26),
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Image.network("${datamodel[index]['image']}"),
                          subtitle: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'price=${datamodel[index][['price']]}',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );

                  },
                )




                    : snapshot.hasError
                    ? Text('Sorry, Someting went wrong try again later')
                    : Center(child: CupertinoActivityIndicator());

              }),



            )
        )
    );

  }



}

