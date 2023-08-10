import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_apps/customer_screens/customer_orders.dart';
import 'package:multi_store_apps/customer_screens/wishlist.dart';
import 'package:multi_store_apps/main_screens/cart.dart';
import 'package:multi_store_apps/widgets/appbar_widgets.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Stack(children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.yellow, Colors.brown])),
              ),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    expandedHeight: 140,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          title: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: constraints.biggest.height <= 120 ? 1 : 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 72),
                              child: Text(
                                'Account',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          background: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.yellow, Colors.brown])),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25, left: 30),
                              child: Row(
                                children: [
                                  data['profileImage'] == ''
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              'images/inapp/guest.jpg'),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              data['profileImage']),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text(
                                      data['name'] == ''
                                          ? 'GUEST'
                                          : data['name'].toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CartScreen(
                                                  back: AppBarBackButton(),
                                                )));
                                  },
                                  child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                          child: Text(
                                        'Cart',
                                        style: TextStyle(
                                            color: Colors.yellow, fontSize: 20),
                                      ))),
                                ),
                              ),
                              Container(
                                color: Colors.yellow,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerOrders()));
                                  },
                                  child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                          child: Text(
                                        'Orders',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20),
                                      ))),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerOrders()));
                                  },
                                  child: SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Center(
                                          child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WishListScreen()));
                                        },
                                        child: Text(
                                          'Wishlist',
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 20),
                                        ),
                                      ))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child:
                              Image(image: AssetImage('images/inapp/logo.jpg')),
                        ),
                        Container(
                          color: Colors.grey.shade300,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                                child: ProfileHeaderLabel(
                                  headerLabel: '  Account Info.  ',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 260,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      RepeatedListtile(
                                          icon: Icons.email,
                                          onPressed: () {},
                                          subTitle: data['email'] == ''
                                              ? 'example@gmail.com'
                                              : data['email'],
                                          title: 'Email Address'),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: YellowDivider(),
                                      ),
                                      RepeatedListtile(
                                        icon: Icons.phone,
                                        subTitle: 'example: +111111',
                                        title: 'Phone No.',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: YellowDivider(),
                                      ),
                                      RepeatedListtile(
                                          icon: Icons.location_pin,
                                          subTitle: data['address'] == ''
                                              ? 'example New Gersy-usa'
                                              : data['address'],
                                          title: 'Addrerss')
                                    ],
                                  ),
                                ),
                              ),
                              ProfileHeaderLabel(
                                  headerLabel: '  Account Settings  '),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 260,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      RepeatedListtile(
                                        title: 'Edit Profile',
                                        subTitle: '',
                                        icon: Icons.edit,
                                        onPressed: () {},
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: YellowDivider(),
                                      ),
                                      RepeatedListtile(
                                        icon: Icons.lock,
                                        title: 'Change Password',
                                        onPressed: () {},
                                      ),
                                      YellowDivider(),
                                      RepeatedListtile(
                                        icon: Icons.logout,
                                        title: 'Log Out',
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          Navigator.pushReplacementNamed(
                                              context, '/welcome_screen');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          );
          Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      },
    );
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListtile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListtile(
      {Key? key,
      required this.icon,
      this.onPressed,
      this.subTitle = '',
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({
    Key? key,
    required this.headerLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          headerLabel,
          style: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            )),
      ],
    );
  }
}
