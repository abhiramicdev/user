import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/APIS/apis.dart';
import 'package:user_app/database/user_databse.dart';
import 'package:user_app/models/user_details.dart';
import 'package:user_app/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dataList;
  var dio = Dio();
  var savedUserList;

  @override
  void initState() {
    _getSavedData();
    super.initState();
  }

  _getSavedData() async {
    var savedData = await DBProvider.DB.getUserDetails();
    setState(() {
      savedUserList = savedData;
      if (savedUserList.isEmpty) {
        getUserDatafromNetwork();
      } else {}
    });
  }

  _savedToDB() {
    for (int i = 0; i < dataList?.length; i++) {
      UserDetails userDetails = UserDetails(
        id: dataList?[i]?["id"],
        name: dataList?[i]?["name"]?.toString(),
        username: dataList?[i]?["username"]?.toString(),
        email: dataList?[i]?["email"]?.toString(),
        profileImage: dataList?[i]?["profile_image"]?.toString(),
        phone: dataList?[i]?["phone"]?.toString(),
        website: dataList?[i]?["website"].toString(),
        street: dataList?[i]?["address"]?["street"].toString(),
        suite: dataList?[i]?["address"]?["suite"].toString(),
        city: dataList?[i]?["address"]?["city"].toString(),
        zipcode: dataList?[i]?["address"]?["zipcode"].toString(),
        companyName: dataList?[i]?["company"]?["name"].toString(),
        catchPhrase: dataList?[i]?["company"]?["catchPhrase"].toString(),
        bs: dataList?[i]?["company"]?["bs"].toString(),
      );

      setState(() {
        DBProvider.DB.addUserInfo(userDetails);
      });
    }
  }

  saveState() async {
    SharedPreferences preftoken = await SharedPreferences.getInstance();
    setState(() {
      preftoken.setString('saved', 'Datasaved');
    });
  }

  Future getUserDatafromNetwork() async {
    try {
      var response = await dio.get(
        options: Options(),
        APIConnectionURL.userData,
      );
      if (response.data != null) {
        setState(() {
          dataList = response.data;
        });
        _savedToDB();
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0F2E39),
        title: const Text("People"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            (savedUserList != [] ||
                    savedUserList != null ||
                    savedUserList.length > 0)
                ? FutureBuilder<List<UserDetails>>(
                    future: DBProvider.DB.getUserDetails(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserDetails>> snapshot) {
                      if (snapshot.hasData) {
                        savedUserList = snapshot.data;
                        return savedUserList.length > 0
                            ? Column(
                                children: [
                                  ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: savedUserList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        savedUserList[index]),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                child: savedUserList?[index]
                                                            ?.profileImage !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            savedUserList?[
                                                                    index]
                                                                ?.profileImage)
                                                    : const Icon(Icons.person,
                                                        size: 24,
                                                        color: Colors.grey)),
                                            title: Text(
                                                savedUserList[index].name ??
                                                    ""),
                                            subtitle: Text(savedUserList[index]
                                                    .companyName ??
                                                ""),
                                          ),
                                        );
                                      }),
                                ],
                              )
                            : const Text('No data');
                      } else if (snapshot.hasError) {
                        return const Text('');
                      } else {
                        return const Text('Loading ...');
                      }
                    })
                : const Center(
                    child: Text('Loading ...'),
                  ),
          ],
        ),
      ),
    );
  }
}
