import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/domain/util/time_to_string.dart';
import 'package:test_app/presentation/view_model/main_view_model.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainViewModel>(
        init: MainViewModel(),
        builder: (vm) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("메인 페이지"),
                centerTitle: true,
              ),
              body: Obx(() => vm.isLoaded.isTrue
                  ? Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: ListView.builder(
                        itemCount: vm.items.length,
                        controller: vm.scrollController,
                        itemBuilder: (context, index) {
                          final item = vm.items.keys.toList()[index];
                          final snapshot = vm.items.values.toList()[index];
                          return InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.black12)),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        item.master.icon,
                                        width: 30,
                                      ),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                        width: 160,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(item.master.name,
                                                style: context
                                                    .textTheme.titleMedium),
                                            Text(
                                              item.master.description,
                                              style:
                                              context.textTheme.bodyMedium,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Text(toDateString(item.before)),
                                    ],
                                  ),
                                  Container(
                                    width: context.width,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            12),
                                        color: Colors.black12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding:
                                            const EdgeInsets
                                                .all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  snapshot[0],
                                                  style: context
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                                Text(
                                                  snapshot[1],
                                                  style: context
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                      color: Colors
                                                          .black54),
                                                  maxLines: 3,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                          const BorderRadius
                                              .only(
                                              topRight: Radius
                                                  .circular(
                                                  12),
                                              bottomRight: Radius
                                                  .circular(
                                                  12)),
                                          child: Image.network(
                                            snapshot[2],
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Obx(() => vm.isUpdate.isTrue
                      ? Center(
                    child: CircularProgressIndicator(
                        color: context.theme.primaryColor),
                  )
                      : Container()),
                ],
              )
              : Center(
                child: CircularProgressIndicator(
                    color: context.theme.primaryColor),
              )));
        });
  }
}
