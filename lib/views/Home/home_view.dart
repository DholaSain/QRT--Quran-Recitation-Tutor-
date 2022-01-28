import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quranapp/views/Test/test_view.dart';
import 'package:quranapp/views/Test/test_view_old.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Rx<bool> isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() {
              return isLoading.value
                  ? const LinearProgressIndicator()
                  : const SizedBox(
                      height: 4,
                      // color: Colors.red,
                    );
            }),
            const SizedBox(height: 15),
            Image.asset('assets/02.jpeg'),
            Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 29,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (context, index) {
                  log("${index + 1}");
                  return GestureDetector(
                    onTap: () async {
                      isLoading.value = true;
                      String link = await firestore
                          .collection('lesson1')
                          .doc("${index + 1}")
                          .get()
                          .then((value) {
                        return value.get('file');
                      });
                      log(link);
                      isLoading.value = false;
                      Get.to(() => TestView(
                            word: "${index + 1}",
                            file: link,
                          ));
                    },
                    child: Image.asset('assets/lesson1/${index + 1}.png'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
