// ignore_for_file: unused_field, prefer_final_fields, sized_box_for_whitespace, avoid_print, unused_element

import 'package:flutter/material.dart';
import 'package:interviewtask/api/api_services.dart';
import 'package:interviewtask/model/businees_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  Future<BusinessModel>? _business;
  int rating = 0;

  @override
  void initState() {
    super.initState();
    _business = ApiServices.getBusinessDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
          child: Container(
            width: 340,
            height: 550,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FutureBuilder<BusinessModel>(
              future: _business,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: PageController(
                            initialPage: 0,
                            keepPage: true,
                            viewportFraction: 1),
                        itemCount: snapshot.data!.pagination.total,
                        itemBuilder: (BuildContext context, int index) {
                          return ListView(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      snapshot.data!.data[index].userDetail
                                          .profileImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        snapshot.data!.data[index].businessName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: RatingBar.builder(
                                    minRating: 0,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    updateOnDrag: true,
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        this.rating = snapshot
                                            .data!.data[index].avgRating;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 35.0, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data!.data[index].totalFeedbackCount} Feedback reviews',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${snapshot.data!.data[index].finishedJobs} Jobs Performed',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                          'Post Job and invite to Bide'),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(240, 50),
                                        primary: Colors.lightBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              const Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        'asset/images/pin.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Location',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ' ${snapshot.data!.data[index].userDetail.city}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        'asset/images/pin.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Member since',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      ' ${snapshot.data!.data[index].userDetail.createdAt.date.day}-${DateFormat("MMMM").format(snapshot.data!.data[index].userDetail.createdAt.date)}-${snapshot.data!.data[index].userDetail.createdAt.date.year}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(snapshot
                                    .data!.data[index].userDetail.address, style: const TextStyle(fontSize: 16),),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
