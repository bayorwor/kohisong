import 'package:flutter/material.dart';
import 'package:kohisong/resources/auth_methods.dart';
import 'package:unicons/unicons.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
            future: AuthMethods().getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(snapshot.data!['profile_image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.black.withOpacity(0.5),
                              margin: const EdgeInsets.all(10),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              color: Colors.red.withOpacity(0.5),
                              margin: const EdgeInsets.all(10),
                              child: IconButton(
                                onPressed: () {
                                  AuthMethods().logoutUser();
                                },
                                icon: const Icon(Icons.exit_to_app),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 5,
                          left: 30,
                          right: 30,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data!['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                      size: 40,
                    ),
                    title: const Text("Email",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(snapshot.data!['email']),
                    trailing:
                        const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      size: 40,
                    ),
                    title: const Text("Phone",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(snapshot.data!['phone']),
                    trailing:
                        const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      size: 40,
                    ),
                    title: const Text("Location",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(snapshot.data!['location']),
                    trailing:
                        const Icon(Icons.check_circle, color: Colors.green),
                  ),
                  ListTile(
                    leading: const Icon(
                      UniconsLine.sim_card,
                      size: 40,
                    ),
                    title: const Text("Ghana ID",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(snapshot.data!['card']),
                    trailing:
                        const Icon(Icons.check_circle, color: Colors.green),
                  ),
                ],
              );
            }));
  }
}
