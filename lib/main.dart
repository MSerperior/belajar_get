import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      unknownRoute: GetPage(name: '/notfound', page: () => const UnknownRoute()),
      getPages: [
        GetPage(
          name: '/',
          page: () => Home(),
        ),
        GetPage(
          name: '/second',
          page: () => Other(),
        ),
        GetPage(
          name: '/third',
          page: () => Third(),
        ),
      ],
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final CountController c = Get.put(CountController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Clicks: ${c.count}")),
      ),
      body: Center(
        child: ElevatedButton(
          child: Obx(() => Text("Go to Other ${c.count}")),
          onPressed: () => Get.toNamed('/second'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Other extends StatelessWidget {
  
  final CountController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("Clicks: ${c.count}")),
            ElevatedButton(
              child: const Text("Go to Third"),
              onPressed: () => Get.toNamed('/third'),
            ),
          ],
        ),
      ),
    );
  }
}

class Third extends StatelessWidget {

  final CountController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Third"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Third"),
            ElevatedButton(
              child: const Icon(Icons.add),
              onPressed: () => c.increment(),
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownRoute extends StatelessWidget {
  const UnknownRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("404 | Not Found"),
      ),
      body: const Center(
        child: Text("404 | Not Found"),
      ),
    );
  }
}

class CountController extends GetxController {
  var count = 0.obs;
  increment() => count++;
}
