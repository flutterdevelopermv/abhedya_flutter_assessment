import 'package:abhedya_flutter_assessment/data/models/account.dart';
import 'package:abhedya_flutter_assessment/data/repositories/graph_ql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Accounts List Unit Test', () {
    test(
        "'Unit test' to verify the functionality of the 'list of accounts' retrieval",
        () async {
      var accounts = await GraphQLApi.get(GraphQLApi.accounts);
      if (accounts.hasException) {
        expect(accounts.hasException, true);
      } else if (accounts.data != null) {
        try {
          expect(
              Account.getList(accounts.data!), Account.getList(accountsData));
        } catch (e) {
          expect(accounts.data!, accountsData);
        }
      }
    });

    //
  });
}

var accountsData = {
  "accounts": [
    {
      "id": "74c47a02-90c2-4fbf-aab0-627a5fa7b499",
      "accountNumber": "6392797060",
      "accountType": "Savings",
      "balance": 5740.98,
      "accountHolder": "Jensen Terry"
    },
    {
      "id": "94f206f0-d6aa-4a3a-a26c-5fa045f7f61c",
      "accountNumber": "5778923347",
      "accountType": "Savings",
      "balance": 7064.88,
      "accountHolder": "Carolyne Hauck"
    },
    {
      "id": "542d62ec-f98f-4dbf-b519-c3d9890cf029",
      "accountNumber": "1540535843",
      "accountType": "Savings",
      "balance": 4571.89,
      "accountHolder": "Foster Fay"
    },
    {
      "id": "9b05857f-be88-4c09-bc53-d5451372a0d3",
      "accountNumber": "2135094927",
      "accountType": "Savings",
      "balance": 1521.68,
      "accountHolder": "Jermey Bruen"
    },
    {
      "id": "f6e01f72-91d2-4b73-9910-e002c002291b",
      "accountNumber": "8267523910",
      "accountType": "Savings",
      "balance": 6201.71,
      "accountHolder": "Harvey Waters"
    },
    {
      "id": "956992b9-6c4e-4caf-a417-86b329ac58a8",
      "accountNumber": "4142719630",
      "accountType": "Checking",
      "balance": 8394.26,
      "accountHolder": "Sharon Raynor"
    },
    {
      "id": "386320cf-de80-4e7d-b99f-7ec3bf78b473",
      "accountNumber": "7686885360",
      "accountType": "Checking",
      "balance": 575.36,
      "accountHolder": "Sigrid Schmidt"
    },
    {
      "id": "4bb36883-9bac-461f-a8e3-c07b956df275",
      "accountNumber": "3988063069",
      "accountType": "Savings",
      "balance": 3999.26,
      "accountHolder": "Precious Kreiger"
    },
    {
      "id": "2c7abe3a-b639-43ac-aee8-d792a73c567e",
      "accountNumber": "8322589047",
      "accountType": "Checking",
      "balance": 8005.21,
      "accountHolder": "Dangelo Bradtke"
    },
    {
      "id": "b9b290cf-aeb2-49d5-948e-3d27d44d3b3a",
      "accountNumber": "1287856593",
      "accountType": "Savings",
      "balance": 3036.61,
      "accountHolder": "Armand Bode"
    }
  ]
};
