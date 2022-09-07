import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/icons_const.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/utils/validate_util.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/view/widgets/custom_button_text.dart';
import 'package:learn_english/view/widgets/custom_text_field.dart';

import '../../../common/constants/images_const.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_image_network.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    userNameController.text = injector<LocalApp>().getStorage(StringConst.userName);
    emailController.text = injector<LocalApp>().getStorage(StringConst.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? avt = injector<LocalApp>().getStringStorage(StringConst.avt);
    print(avt);
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            const CustomAppbar(
              title: 'Edit profile',
              haveIcon1: false,
              haveIcon2: false,
              haveIconPop: true,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => changeAvt(),
              child: CustomImageNetwork(
                height: 100,
                width: 100,
                url: avt,
                border: 50,
                isAvatar: true,
                urlAvt: avt,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      onValidate: ValidateUtil.validEmpty,
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: userNameController,
                      hintText: "User Name",
                      onValidate: ValidateUtil.validEmpty,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomButtonText(
          onTab: () {
            Navigator.pop(context);
          },
          text: 'Xong',
        ),
      ),
    );
  }

  void changeAvt() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(-1, -1), // Shadow position
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.7, crossAxisSpacing: 0.8),
                  scrollDirection: Axis.vertical,
                  itemCount: ImageConst.listAvt.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await injector<LocalApp>().saveStringStorage(StringConst.avt, ImageConst.listAvt[index]);
                        setState(() {});
                      },
                      child: Image.asset(
                        ImageConst.listAvt[index],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
