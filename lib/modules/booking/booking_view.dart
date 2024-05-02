import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harbourhouse/modules/login/login_view/login_view.dart';
import 'package:harbourhouse/modules/venue/venue_view.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../resources/app_colors.dart';
import '../../utils/common.dart';
import '../../utils/widgets/loader_no_data.dart';
import 'booking_vm.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingVM>(builder: (c) {
      return Scaffold(
          bottomSheet: !c.showPayment!
              ? null
              : DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  minChildSize: 0.1,
                  maxChildSize: 0.3,
                  expand: false,
                  builder: (context, scrollController) {
                    return Container(
                      //height: 600,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 15,
                              color: CupertinoColors.extraLightBackgroundGray,
                            )
                          ]),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 8,
                                width: 75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: CupertinoColors.lightBackgroundGray),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyle(
                                    color: AppColors.accentPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "₹${c.totalPrice!.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: AppColors.accentPrimary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking Price",
                                style: TextStyle(
                                    color: AppColors.accentPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "₹300.00",
                                style: TextStyle(
                                    color: AppColors.accentPrimary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Remaining amount will be payable at The Harbour House. Booking amount is non-refundable and non-transferable",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.accentPrimary
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppPrimaryButton(
                              onPressed: () {
                                c.bookSlots();
                              },
                              text: c.role == "A" ? "Self book" : "Pay & Book")
                        ],
                      ),
                    );
                  },
                ),
          appBar: MyAppBar(
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.accentPrimary,
                )),
            heading: c.zoneVM.selectedZone!.name,
            actions: [
              InkWell(
                  onTap: () {
                    c.toggleZoneInfo();
                  },
                  child: Icon(
                    c.showZoneInfo! ? Icons.close : Icons.keyboard_arrow_down,
                    color: AppColors.accentPrimary,
                    size: 25,
                  ))
            ],
          ),
          body: ListView(children: [
            c.showZoneInfo!
                ? Column(
                    children: [
                      Container(
                          width: MediaQuery.of(getContext()).size.width - 50,
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          height: 200,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  c.zoneVM.selectedZone!.zoneImg!.length,
                                  (index) {
                                return Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width:
                                        MediaQuery.of(getContext()).size.width -
                                            60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          c.zoneVM.selectedZone!.zoneImg![index]
                                              .toString(),
                                          fit: BoxFit.cover,
                                        )));
                              }),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              c.zoneVM.selectedZone!.name!,
                              style: TextStyle(
                                  color: AppColors.accentPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              c.zoneVM.selectedZone!.discription!,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, bottom: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: AppColors.accentPrimary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              c.zoneVM.timeFormatHHmm(c.zoneVM
                                      .timeFormatFromApi(
                                          c.zoneVM.selectedZone!.openTime!))! +
                                  " - " +
                                  c.zoneVM.timeFormatHHmm(c.zoneVM
                                      .timeFormatFromApi(
                                          c.zoneVM.selectedZone!.closeTime!))!,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18),
                            ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_seat_rounded,
                              color: AppColors.accentPrimary,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              "Slot duration: ${c.zoneVM.selectedZone!.slot} mins",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18),
                            ))
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            // Padding(
            //   padding: const EdgeInsets.only(left: 22, bottom: 10),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.local_parking,
            //         color: AppColors.accentPrimary,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Expanded(
            //           child: Text(
            //         "Amenities",
            //         style: TextStyle(
            //             color: Colors.black87,
            //             fontWeight: FontWeight.w300,
            //             fontSize: 18),
            //       ))
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.only(left: 22, bottom: 10, top: 10),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           child: Text(
            //         "Zones",
            //         style: TextStyle(
            //             color: Colors.black87,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 22),
            //       ))
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 15,
                        color: CupertinoColors.lightBackgroundGray)
                  ]),
              child: TableCalendar(
                firstDay: DateTime.now(),
                focusedDay: c.selectedDateTime!,
                calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                        color: AppColors.accentPrimary.withOpacity(0.7),
                        //borderRadius: BorderRadius.circular(100),
                        shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                        color: AppColors.accentPrimary,
                        //borderRadius: BorderRadius.circular(100),
                        shape: BoxShape.circle),
                    selectedTextStyle: TextStyle(color: AppColors.btnPrimary)),
                lastDay: DateTime(2100),
                headerVisible: true,
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return isSameDay(c.selectedDateTime, day);
                },
                onDaySelected: (selectedDay, focusedDay) async {
                  debugPrint("selectedDay $selectedDay");
                  c.selectedDateTime = selectedDay;
                  c.selectedSlot = -1;
                  c.selectedDate =
                      DateFormat("yyyy-MM-dd").format(c.selectedDateTime!);
                  c.dateStrFrom = DateFormat("yyyy-MM-dd").format(c.selectedDateTime!);
                  c.dateStrTo = c.dateStrFrom;    
                  await c.generateSlots();
                  c.update();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: c.allSlots.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: c.allSlots[index].bookFlag.toString() == "1"
                              ? AppColors.accentPrimary
                              : c.allSlots[index].isSelected!
                                  ? Colors.lightGreen
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: CupertinoColors.extraLightBackgroundGray,
                                blurRadius: 10,
                                offset: Offset(1, 1))
                          ]),
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap:
                              // (c.slots![index]!.slotBlockStatus
                              //                 .toString() ==
                              //             "1" ||
                              //         c.slots![index]!.slotBookingStatus
                              //                 .toString() ==
                              //             "1")
                              //     ?
                              //() {
                              // Get.dialog(Center(
                              //   child: Wrap(
                              //     children: [
                              //       Material(
                              //         type: MaterialType.transparency,
                              //         child: Container(
                              //           margin: EdgeInsets.symmetric(horizontal: 24),
                              //           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(16),
                              //             color: Colors.white
                              //           ),
                              //           child:
                              //           c.slots![index]!.slotBookingDetail!=null ?
                              //           Column(
                              //             mainAxisSize: MainAxisSize.min,
                              //             children: [
                              //               Row(
                              //                 mainAxisSize: MainAxisSize.max,
                              //                 mainAxisAlignment: MainAxisAlignment.center,
                              //                 children: [
                              //                   setCardHeading("Booked by"),
                              //                 ],
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     setHeadlineMedium("Name"),
                              //                     setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.name.toString(), color: PRIMARY_COLOR)
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Divider(),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     setHeadlineMedium("Phone"),
                              //                     setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.phone.toString(), color: PRIMARY_COLOR)
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Divider(),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     setHeadlineMedium("email"),
                              //                     setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.email.toString(), color: PRIMARY_COLOR)
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Divider(),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     setHeadlineMedium("Booking status"),
                              //                     setMediumLabel(c.slots![index]!.slotBookingDetail!.bookingStatus.toString(), color: PRIMARY_COLOR)
                              //                   ],
                              //                 ),
                              //               ),
                              //               const Divider(),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: Row(
                              //                   mainAxisSize: MainAxisSize.max,
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     setHeadlineMedium("email"),
                              //                     setMediumLabel(c.slots![index]!.slotBookingDetail!.user!.email.toString(), color: PRIMARY_COLOR)
                              //                   ],
                              //                 ),
                              //               )
                              //             ],
                              //           ): Container(
                              //             height: 150,
                              //             child: Center(
                              //               child: Text("No Info available"),
                              //             ),
                              //           )
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ));
                              //   }
                              //:
                              c.allSlots[index].bookFlag!.toString() == "1"
                                  ? null
                                  : () {
                                      c.allSlots[index].isSelected =
                                          !c.allSlots[index].isSelected!;
                                      int idx =
                                          c.allSlots.indexWhere((element) {
                                        return element.isSelected == true;
                                      });
                                      if (idx != -1) {
                                        c.showPayment = true;
                                      } else {
                                        c.showPayment = false;
                                      }
                                      c.calculateRate();
                                      c.update();
                                    },
                          child: Container(
                            //color: Colors.white,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(c.allSlots[index].fromDate!,
                                    style: TextStyle(
                                      color:  c.allSlots[index].bookFlag.toString() == "1" ? AppColors.btnPrimary : AppColors.accentPrimary
                                    ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      child: Text(
                                        "TO",
                                      
                                    style: TextStyle(
                                      fontSize: 8, color:  c.allSlots[index].bookFlag.toString() == "1" ? AppColors.btnPrimary : AppColors.accentPrimary
                                    ),
                                      ),
                                    ),
                                    Text(c.allSlots[index].toDate!,
                                    style: TextStyle(
                                      color:  c.allSlots[index].bookFlag.toString() == "1" ? AppColors.btnPrimary : AppColors.accentPrimary
                                    ),),
                                    //SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 150,
            )

            // c.isLoading!
            //     ? const Loader()
            //     : c.slots.isEmpty
            //         ? const NoData()
            //         : ListView.builder(
            //             itemCount: c.slots.length,
            //             itemBuilder: (context, index) {
            //               return Container(
            //                 child: const Center(
            //                     child: Text(
            //                         "Show Slots/Create Slots/Edit Slots/Book Slots")),
            //               );
            //             },
            //           )
          ]));
    });
  }
}
