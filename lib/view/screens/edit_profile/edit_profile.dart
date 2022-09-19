import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/global_app_cache/global_app_cache.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/utils/common_util.dart';
import 'package:learn_english/common/utils/validate_util.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/provider/profile_provider.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/screens/edit_profile/widgets/edit_profile_egroup_level.dart';
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
  String? _eGroupLevel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userNameController.text = injector<LocalApp>().getStorage(StringConst.userName);
    _eGroupLevel = injector<LocalApp>().getStorage(StringConst.level);
    emailController.text = injector<LocalApp>().getStorage(StringConst.email);
    super.initState();
  }

  void _onSelectEGroup() {
    CommonUtil.showCustomBottomSheet(
        context: context,
        height: 350,
        child: EGroupLevel(
          onTap: (String level) {
            setState(() {
              _eGroupLevel = level;
            });
          },
        ));
  }

  void _onUpdate() async {
    CommonUtil.dismissKeyBoard(context);
    if (!CommonUtil.validateAndSave(_formKey)) return;
    if (_eGroupLevel == null) {
      CommonUtil.showSnackBar(
        context,
        color: Colors.grey,
        title: 'Vui lòng chọn EGroup Level',
      );
      return;
    }
    await ProfileProvider().onUpdateUser(
      context,
      userNameController.text,
      _eGroupLevel!,
    );
    GlobalAppCache.instance.setForRegister(false);
    await Navigator.pushNamed(context, RoutingNameConstant.confirmEmail);
    GlobalAppCache.instance.setForRegister(true);
  }

  @override
  Widget build(BuildContext context) {
    String? avt = injector<LocalApp>().getStringStorage(StringConst.avt);
    return Scaffold(
      body: Form(
        key: _formKey,
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
                      readOnly: true,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      controller: userNameController,
                      hintText: "User Name",
                      onValidate: ValidateUtil.validEmpty,
                      textInputAction: TextInputAction.done,
                    ),
                    InkWell(
                      onTap: _onSelectEGroup,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 16),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'EGroup Level: ', style: Theme.of(context).textTheme.titleSmall),
                                      TextSpan(
                                          text: _eGroupLevel != null ? '$_eGroupLevel' : '',
                                          style: Theme.of(context).textTheme.titleSmall),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: CustomButtonText(
            onTab: _onUpdate,
            text: 'Xong',
          ),
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
