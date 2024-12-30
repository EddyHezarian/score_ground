import 'package:ai_pr5/controller/game.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BoardScreen extends StatelessWidget {
  BoardScreen({super.key});
  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Score Ground"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _scoreBoard(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  return Item(index: index);
                },
                itemCount: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  c.restGame();
                },
                child: const Text("Reset"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _scoreBoard() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(bottom: 25, top: 20, right: 12, left: 12),
        width: double.maxFinite,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(158, 208, 234, 255),
        ),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    c.game.value.player.score.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Container(
                height: 30,
                width: 1,
                color: Colors.black,
              ),
              Row(
                children: [
                  Text(
                    c.game.value.ai.score.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(Icons.computer),
                ],
              ),
            ],
          ),
        ));
  }
}

class Item extends StatelessWidget {
  Item({
    super.key,
    required this.index,
  });
  final int index;
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            c.movePlayer(index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: index == c.game.value.player.location
                  ? Colors.green
                  : index == c.game.value.ai.location
                      ? Colors.red
                      : Colors.white,
              border: Border.all(color: Colors.black),
            ),
            child: Center(
                child:c.game.value.player.location == index
                    ? const Icon(Icons.person)
                    : c.game.value.ai.location == index
                        ? const Icon(Icons.computer)
                        : Text( c.game.value.scores[index].toString())),
          ),
        ));
  }
}
