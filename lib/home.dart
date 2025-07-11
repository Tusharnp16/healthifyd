import 'package:flutter/material.dart';

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello,",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Healthify Team",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                        height: 50,
                        width: 50,
                        child: ClipOval(
                            child: Image.asset("assets/images/admin.jpg")))
                  ],
                ),Divider(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Appoiments",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify (tonybhai,Kamlesh & heamnt)",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify tonybhai,kamlesh & heamnt",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/Hospi.png",fit: BoxFit.fitWidth)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("New hospital in surat inaugurate by founder of healthify tonybhai ,kamlesh & heamnt",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/lakshadweep.jpeg",fit: BoxFit.fill)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Tonybhai(Healthify founder) going to open new branch of healthify at Lakshadweep meeting done with PM MODI",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/lsgamount.jpg",fit: BoxFit.fill)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("LSG get new sponsorship of whoping amount 699 CR from Healthify ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/biden.jpg",fit: BoxFit.fill)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Healthify founder attain meeting with biden there might be chance to open new brakch of healthify at USA ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),)),
                                    SizedBox(height: 2,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 190,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:140,
                                      width: double.infinity,
                                      child:
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: SizedBox.fromSize(
                                            size: Size.fromRadius(48), // Image radius
                                            child: Image.asset("assets/images/marriage.jpg",fit: BoxFit.fill)
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2,),
                                    const Expanded(child: Text("Jaffa!!! Healthify founder hemant dating to shradhha kapoor and there have plan of marriage next year ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),)),
                                    SizedBox(height: 2,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
