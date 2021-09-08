import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:claveto/wIdgets/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';
import 'model/home_screen_model.dart';
import 'models/appointement/book_appointment_body.dart';
import 'models/appointement/check_before_response.dart';
import 'notification_example.dart';
import 'payment/razorpay_payment.dart';
import 'payment_success/payment_success.dart';
import 'rest/api_services.dart';

class CheckOut extends StatefulWidget {
  final Doctor doctorDetails;
  final String selectedDate, selectedTime;
  final String appointmentType; // online,clinic,lab
  final int familyMemberID;
  final double totalPrice;
  final bool isLab;
  final Lab lab;

  final List<String> packagesIds;

  const CheckOut(
      {Key key,
      this.doctorDetails,
      this.selectedDate,
      this.selectedTime,
      this.appointmentType,
      this.familyMemberID,
      this.totalPrice,
      //this.packagesIds,
      this.isLab = false,
      this.lab,
      this.packagesIds})
      : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double totalAmount = 599, discountedAmount = 0.0, amountToBePaid;

  /// 1 for not used , 2 for coupon failed, 3 fro coupon applied success
  int couponApplied, clave;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    couponApplied = 1;
    clave = 0;
    //print('List length ${widget.packagesIds.length}');
    totalAmount = widget.totalPrice;
    amountToBePaid = totalAmount - discountedAmount;
    print('widget.selectedTime ${widget.selectedTime.substring(0, 2)}');
    print('widget.selectedTime ${widget.selectedTime.substring(3, 5)}');
    print('widget.selectedTime ${widget.selectedDate.substring(0, 4)}');
    print('widget.selectedTime ${widget.selectedDate.substring(5, 7)}');
    print('widget.selectedTime ${widget.selectedDate.substring(8, 10)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff14B4A5),
                Color(0xff3883EF),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.all(5),
              child: Text("Order Summary",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.lightBlueAccent.withOpacity(0.7),
                          fontSize: 20))),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      widget.isLab
                          ? Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff14B4A5),
                                    Color(0xff3883EF),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lab Name: ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Expanded(
                                            child: Text(
                                          '${widget.lab.labDetailsNew.legalName}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 130,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Container(
                                                  color: Colors.white,
                                                  child: Image.network(
                                                     
                                                          widget.lab.avatar)))),
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 9, vertical: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Name: ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .30,
                                                      child: Text(
                                                        '${widget.lab.labDetailsNew.firstName + " " + widget.lab.labDetailsNew.middleName + " " + widget.lab.labDetailsNew.lastName}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Address: ',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .30,
                                                      child: Text(
                                                        '${widget.lab.labDetailsNew.address}',
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'City: ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .30,
                                                      child: Text(
                                                        '${widget.lab.labDetailsNew.city}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'State: ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .30,
                                                    child: Text(
                                                      '${widget.lab.labDetailsNew.state}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'PinCode: ',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .30,
                                                    child: Text(
                                                      '${widget.lab.labDetailsNew.pincode}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      
                                          widget.doctorDetails.avatar,
                                    ),
                                    radius: 50,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width *
                                            .45,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 0),
                                        child: Text(
                                            widget.doctorDetails.doctorDetailsNew
                                                    .firstName +
                                                " " +
                                                widget
                                                    .doctorDetails
                                                    .doctorDetailsNew
                                                    .middleName +
                                                " " +
                                                widget
                                                    .doctorDetails
                                                    .doctorDetailsNew
                                                    .lastName[0],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors.lightBlueAccent
                                                        .withOpacity(0.7),
                                                    fontSize: 18)))),
                                    // Container(
                                    //     margin: EdgeInsets.symmetric(
                                    //         horizontal: 5, vertical: 1),
                                    //     child: Text('BMS, MD',
                                    //         style: GoogleFonts.montserrat(
                                    //             textStyle: TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontSize: 15)))),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .40,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Text(
                                            widget.doctorDetails
                                                .doctorDetailsNew.address,
                                            maxLines: 3,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)))),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 0),
                                        child: Text(
                                            widget.doctorDetails
                                                .doctorDetailsNew.city,
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14)))),
                                  ],
                                ),
                              ],
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.5),
                                ),
                                Text(
                                  "   ${widget.selectedDate}",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.5),
                                ),
                                Text(
                                  "  ${widget.selectedTime}",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 0.8,
                      ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //   padding: EdgeInsets.all(5),
                      //   child: Text("Apply Coupons",
                      //       textAlign: TextAlign.left,
                      //       style: GoogleFonts.montserrat(
                      //           textStyle: TextStyle(
                      //               color:
                      //                   Colors.lightBlueAccent.withOpacity(0.7),
                      //               fontSize: 15))),
                      // ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //   padding: EdgeInsets.all(5),
                      //   decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),
                      //     borderRadius: BorderRadius.circular(35),),
                      //
                      //   child: TextField(decoration: new InputDecoration(
                      //       border: InputBorder.none,
                      //       focusedBorder: InputBorder.none,
                      //       enabledBorder: InputBorder.none,
                      //       errorBorder: InputBorder.none,
                      //       disabledBorder: InputBorder.none,
                      //       contentPadding:
                      //       EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      //       hintText: 'Coupon Code'),
                      //
                      //       // child: Text("Enter Code",textAlign: TextAlign.left,
                      //       //     style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12))),
                      //       ),
                      // ),
                      Row(
                        children: [
                          InkWell(
                            onTap: _applyCoupon,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              padding: EdgeInsets.all(5),
                              child: Text("Apply New Member Coupons",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.lightBlueAccent
                                              .withOpacity(0.7),
                                          fontSize: 15))),
                            ),
                          ),

                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: 20, vertical: 5),
                          //   padding: EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey)),
                          //   child: Text("Enter Code",
                          //       textAlign: TextAlign.left,
                          //       style: GoogleFonts.montserrat(
                          //           textStyle: TextStyle(
                          //               color: Colors.black.withOpacity(0.7),
                          //               fontSize: 12))),
                          // ),
                        ],
                      ),
                      getCouponWidget(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text("Cost",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 18))),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text(totalAmount.toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 18))),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text("Discount",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 18))),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text("-$discountedAmount",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 18))),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text("Amount to be paid",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.blue.withOpacity(0.7),
                                        fontSize: 18))),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text("$amountToBePaid",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.blue.withOpacity(0.7),
                                        fontSize: 18))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xff14B4A5),
                      Color(0xff3883EF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(590)),
              child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$amountToBePaid',
                        style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      Text(
                        'Place Order',
                        style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ],
                  ),
                  onPressed: () => {
                        /// open checkout is [razorpay] payment gateway method
                        openCheckout(
                            payment: amountToBePaid ?? 0,
                            handlePaymentSuccess: (response) {
                              // TODO Need to call api for new clave ask fazil for more

                              var id;
                              if (widget.isLab) {
                                id = widget.lab.labDetailsNew.userId.toString();
                              } else {
                                id = widget
                                    .doctorDetails.doctorDetailsNew.userId
                                    .toString();
                              }

                              BookAppointmentRequestModel model =
                                  BookAppointmentRequestModel(
                                timeOfAppointment: widget.selectedTime,
                                docLabId: id,
                                amountToBePaid: amountToBePaid.toString(),
                                familyMemberId:
                                    widget.familyMemberID.toString(),
                                appointmentType:
                                    widget.appointmentType ?? 'clinic',
                                calculatedDiscountAmount:
                                    discountedAmount.toString(),
                                dateOfAppointment: widget.selectedDate,
                                razorpayId: response.paymentId,
                                packages: widget.packagesIds,
                                isLab: widget.isLab,
                                newClave: clave.toString(),
                                totalAmount: totalAmount.toString(),
                              );
                              print('Model ${model.toJson()}');
                              CheckBeforeResponseModel check;
                              bookAppointment(model).then((value) {
                                check = CheckBeforeResponseModel.fromJson(
                                    jsonDecode(value));
                                check.status == 200
                                    ? _navigateTOAppointmentSuccessScreen()
                                    : showSnackBar(message: check.message);
                              }).catchError((error) {
                                showSnackBar(message: error.toString());
                              });
                              print("Resonse ${response.toString()}");
                            },
                            handlePaymentError: (response) {
                              print(
                                  "Payment Error ${response.message.toString()}");
                            })
                      }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _zonedScheduleNotification() async {
    print('widget.selectedTime ${widget.selectedTime.substring(0, 2)}');
    print('widget.selectedTime ${widget.selectedTime.substring(3, 5)}');
    print('widget.selectedTime ${widget.selectedDate.substring(0, 4)}');
    print('widget.selectedTime ${widget.selectedDate.substring(5, 7)}');
    print('widget.selectedTime ${widget.selectedDate.substring(8, 10)}');
    int year = int.parse(widget.selectedDate.substring(0, 4));
    int month = int.parse(widget.selectedDate.substring(5, 7));
    int date = int.parse(widget.selectedDate.substring(8, 10));
    int hour = int.parse(widget.selectedTime.substring(0, 2));
    int minutes = int.parse(widget.selectedTime.substring(3, 5));

    DateTime dateTime = DateTime(year, month, date, hour, minutes, 0, 0, 0);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title ${dateTime.toString()}',
        'scheduled body',
        tz.TZDateTime.from(dateTime, tz.local),
        //.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        payload: 'This is scheduled notification',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  _navigateTOAppointmentSuccessScreen() async {
    // todo add motification laucnch
    await _zonedScheduleNotification();

    Route newRoute =
        MaterialPageRoute(builder: (_) => AppointmentSuccessScreen());
    Route oldRoute =
        MaterialPageRoute(builder: (_) => AppointmentSuccessScreen());

    Navigator.pushReplacement(context, newRoute);
    //Navigator.replace(context,oldRoute: ,newRoute: newRoute);
  }

  void _applyCoupon() async {
    String message = await checkNewUserDiscount();
    if (message.contains('coupon eligible')) {
      print('Coupon applied');
      couponApplied = 3;
      clave = 1;
      discountedAmount = 0.50 * totalAmount;
      if (discountedAmount > 100) {
        discountedAmount = 100;
        amountToBePaid = totalAmount - discountedAmount;
      }
    } else {
      print('Coupon applied Failed');

      //discountedAmount = 0.50*totalAmount;

      clave = 0;
      couponApplied = 2;
    }
    amountToBePaid = totalAmount - discountedAmount;
    setState(() {});
  }

  Widget getCouponWidget() {
    switch (couponApplied) {
      case 1:
        return Container();
        break;
      case 2:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.red),
          child: Text('Failed',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(1), fontSize: 19))),
        );
        break;
      case 3:
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.green),
          child: Text('Success',
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.green.withOpacity(0.7), fontSize: 15))),
        );
        break;
      default:
        return Container();
    }
  }
}
