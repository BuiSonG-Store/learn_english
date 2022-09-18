import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/exceptions/timeout_exception.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/configs.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/log_in_model.dart';
import 'package:learn_english/provider/loading_provider.dart';

class AppClient {
  AppClient();

  Future<dynamic> get(String endPoint,
      {bool token = false, bool refreshToken = false}) async {
    try {
      LoadingProvider.instance.onShowLoading(true);
      var url = Uri.parse('${Configurations.host}$endPoint');
      Response? response;
      var data;
      try {
        if (token) {
          response = await http.get(url, headers: {
            'Authorization':
                "Bearer ${injector<LocalApp>().getStringStorage(StringConst.keySaveToken)}"
          }).timeout(const Duration(seconds: Configurations.connectTimeout),
              onTimeout: () {
            LoadingProvider.instance.onShowLoading(false);
            throw TimeOutException();
          });
        } else {
          response = await http
              .get(url)
              .timeout(const Duration(seconds: Configurations.connectTimeout),
                  onTimeout: () {
            LoadingProvider.instance.onShowLoading(false);
            throw TimeOutException();
          });
        }
        if (response.statusCode == 401 && !refreshToken) {
          await makeRefreshToken();
          return await get(endPoint, token: true, refreshToken: true);
        }
        data = json.decode(response.body);

        return data;
      } catch (e) {
        if (e.runtimeType == TimeOutException) {
          throw TimeOutException();
        }
        return {};
      }
    } catch (e) {
      rethrow;
    } finally {
      LoadingProvider.instance.onShowLoading(false);
    }
  }

  Future<Map<String, dynamic>> post(String endPoint,
      {dynamic body, bool formData = false, bool refreshToken = false}) async {
    try {
      var url = Uri.parse('${Configurations.host}$endPoint');
      Response? response;
      Map<String, dynamic> data = {};
      if (formData) {
        response = await http
            .post(url,
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization':
                      "Bearer ${injector<LocalApp>().getStringStorage(StringConst.keySaveToken)}",
                },
                body: json.encode(body))
            .timeout(const Duration(seconds: Configurations.connectTimeout),
                onTimeout: () {
          LoadingProvider.instance.onShowLoading(false);
          throw TimeOutException();
        });
      } else {
        response = await http.post(url, body: json.encode(body), headers: {
          'Content-Type': 'application/json',
          'Authorization':
              "Bearer ${injector<LocalApp>().getStringStorage(StringConst.keySaveToken)}"
        }).timeout(const Duration(seconds: Configurations.connectTimeout),
            onTimeout: () {
          LoadingProvider.instance.onShowLoading(false);
          throw TimeOutException();
        });
      }
      if (response.statusCode == 401 && !refreshToken) {
        await makeRefreshToken();
        return await post(endPoint, refreshToken: true);
      }
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      return data;
    } catch (e) {
      rethrow;
    } finally {
      LoadingProvider.instance.onShowLoading(false);
    }
  }

  Future<dynamic> put(String endPoint,
      {dynamic body, bool formData = false, bool refreshToken = false}) async {
    try {
      var url = Uri.parse('${Configurations.host}$endPoint');
      Map<String, dynamic> data = {};
      Response response = await http
          .put(url, body: json.encode(body), headers: {
        'Content-Type': 'application/json',
        'Authorization':
            "Bearer ${injector<LocalApp>().getStringStorage(StringConst.keySaveToken)}"
      }).timeout(const Duration(seconds: Configurations.connectTimeout),
              onTimeout: () {
        LoadingProvider.instance.onShowLoading(false);
        throw TimeOutException();
      });
      if (response.statusCode == 401 && !refreshToken) {
        await makeRefreshToken();
        return await put(endPoint, refreshToken: true);
      }
      if (response.body.isNotEmpty) {
        data = json.decode(response.body);
      }
      return data;
    } catch (e) {
      rethrow;
    } finally {
      LoadingProvider.instance.onShowLoading(false);
    }
  }

  Future makeRefreshToken() async {
    String? refreshToken =
        injector<LocalApp>().getStringStorage(StringConst.keySaveReFreshToken);
    await _getNewAccessToken(refreshToken);
  }

  Future<String?> _getNewAccessToken(String? refreshToken) async {
    Map<String, dynamic> dataJson = {};
    Response? response;
    try {
      if (refreshToken == null) {
        return null;
      }
      LoginModel loginModel;
      var url = Uri.parse(
        '${Configurations.host}token/refresh_token',
      );
      response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({"refreshToken": refreshToken}));
      dataJson = json.decode(response.body);
      loginModel = LoginModel.fromJson(dataJson);
      await injector<LocalApp>().saveStringStorage(
          StringConst.keySaveToken, loginModel.accessToken ?? '');
      await injector<LocalApp>().saveStringStorage(
          StringConst.keySaveReFreshToken, loginModel.refreshToken ?? '');
      return loginModel.accessToken;
    } catch (_) {}
  }
}
