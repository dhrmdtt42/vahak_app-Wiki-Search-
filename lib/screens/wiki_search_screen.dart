import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vahak_app/model/wiki_search_result_model.dart';
import 'package:vahak_app/provider/provider_model.dart';
import 'package:vahak_app/screens/wiki_search_details.dart';
import 'package:vahak_app/utils/my_utils.dart';

class WikiSearchScreen extends StatefulWidget {
  @override
  _WikiSearchScreenState createState() => _WikiSearchScreenState();
}

class _WikiSearchScreenState extends State<WikiSearchScreen> {
  TextEditingController searchTextEditController = new TextEditingController();
  List<Pages> wikiDataList = new List<Pages>();
  SharedPreferences preferences;
  Map responseData = new Map();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wiki Search"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TextField(
                  controller: searchTextEditController,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25.0,
                      color: Colors.grey,
                    ),
                    suffixIcon: Icon(
                      Icons.mic,
                      size: 25.0,
                      color: Colors.redAccent,
                    ),
                    hintText: "Search City Here",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
//                      border: const OutlineInputBorder(),
//                      enabledBorder: OutlineInputBorder(
//                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                          borderSide: BorderSide(color: Colors.black)
//                      )
                  ),
                  onChanged: (val) {
                    String searchText = searchTextEditController.text.trim();
                    getWikiSearchApiCall(context, searchText);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              child: wikiDataList == null
                  ? Center(
                      child: Container(
                        child: Text(
                          "No Data Found",
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: wikiDataList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        String searchTitle;
                        String desc;
                        String imgUrl;
                        if (wikiDataList != null) {
                          Pages pageItem = new Pages();
                          pageItem = wikiDataList[index];
                          searchTitle = pageItem.title;
                          desc = pageItem.terms.description[0];
                          if (pageItem?.thumbnail?.source != null)
                            imgUrl = pageItem.thumbnail.source;
                        }
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext) =>
                                          WikiSearchDetails(
                                            title: searchTitle,
                                            description: desc,
                                            image: imgUrl,
                                          )));
                            },
                            leading: imgUrl != null
                                ? Image.network(
                                    imgUrl,
                                    height: 50,
                                    width: 50,
                                  )
                                : Container(),
                            title: Text("$searchTitle"),
                            subtitle: Text("$desc"),
                            dense: false,
                          ),
                        );
                      }),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void getWikiSearchApiCall(BuildContext context, String searchText) async {
    var wikiBaseResponse =
        await Provider.of<ProviderModel>(context, listen: false)
            .getCityDataApiCall(context, searchText);

    setState(() {
      MyUtils utils = MyUtils();
      if (wikiBaseResponse != null) {
        utils.saveResponse(wikiBaseResponse);
      }
      responseData = jsonDecode(wikiBaseResponse.body);
      if (responseData != null && responseData != "null") {
        WikiSearchResultModel wikiData = new WikiSearchResultModel();
        wikiData = WikiSearchResultModel.fromJson(responseData);
        wikiDataList = wikiData?.query?.pages;
        print(wikiDataList.toString());
      } else {
        getResponseData();
//
//        responseData = getResponseData();
      }
    });
  }

  getResponseData() async {
    var responseBody = await preferences.getString("response");
    responseData = jsonDecode(responseBody);
    WikiSearchResultModel wikiData =
        WikiSearchResultModel.fromJson(responseData);
    wikiDataList = wikiData?.query?.pages;
    print(wikiDataList.toString());
  }
}
