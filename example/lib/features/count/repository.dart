// class Repository extends BaseApiClient {
//   final http.Client httpClient;
//
//   const AccountRepository({required this.httpClient});
//
//   //
//   Future<bool> checkLogin(AccountDTO dto) async {
//     final url = '/accounts';
//     bool check = false;
//     final request = await postLoginApi(url, dto.toJson());
//     if (request.statusCode == 200) {
//       String token = request.body;
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//       AccountTokenDTO accountTokenDTO = AccountTokenDTO.fromJson(decodedToken);
//       AuthenticateHelper.instance.updateAuthentication(
//         isAuthen: true,
//         accountId: accountTokenDTO.accountId,
//         tokenAccount: token,
//         firstName: accountTokenDTO.firstName,
//         lastName: accountTokenDTO.lastName,
//         avatar: accountTokenDTO.avatar,
//       );
//       check = true;
//     }
//     return check;
//   }
// }
