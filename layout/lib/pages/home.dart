import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          //หน้าปัจจุบันที่เลือก
          currentIndex: 0,
          items: [
            //
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: "Contact",
            )
          ],
          onTap: (index) {
            setState(() {
              print(index);
            });
          },
        ),
        appBar: AppBar(
          title: Text('แอพความรู้เกี่ยวกับคณะวิศวกรรมคอมพิวเตอร์'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              //var data = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Mybox(
                      snapshot.data[index]["title"],
                      snapshot.data[index]["subtitle"],
                      snapshot.data[index]["image_url"],
                      snapshot.data[index]["detail"]);
                },
                itemCount: snapshot.data.length,
              );
            },
            future: getData(),
            //future:
            //    DefaultAssetBundle.of(context).loadString('assets/data.json'),
          ),
        ));
  }

  Widget Mybox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      //color: Colors.blue[50],
      height: 150,
      decoration: BoxDecoration(
          //color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.50), BlendMode.darken)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              offset: Offset(3, 3),
              blurRadius: 3,
              spreadRadius: 0,
            )
          ]),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, //Colum แนวตั้ง
        crossAxisAlignment: CrossAxisAlignment.start, //Row แนวนอน
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 18,
          ),
          TextButton(
            onPressed: () {
              print("Next Page>>>");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(v1, v2, v3, v4)));
            },
            child: Text(
              "อ่านต่อ",
            ),
          )
        ],
      ),
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/Pearwa-likeLion/BasicAPI/main/data.json
    var url = Uri.https('raw.githubusercontent.com',
        '/Pearwa-likeLion/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
