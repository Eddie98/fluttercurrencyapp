const keyLogin = '_key_login';
const keyToken = '_key_token';

const invalidLogPass = 'Invalid login or password';

final testAuthData = {'login': 20234561, 'password': 'ladevi31'};

const String peanutBaseUrl = 'https://peanut.ifxdb.com/api/ClientCabinetBasic';
const String peanutAuthUrl = '$peanutBaseUrl/IsAccountCredentialsCorrect';
const String peanutGetAccountInfoUrl = '$peanutBaseUrl/GetAccountInformation';
const String peanutGetLastFourNumbersPhoneUrl =
    '$peanutBaseUrl/GetLastFourNumbersPhone';

const String partnerBaseUrl = 'https://client-api.contentdatapro.com';
const String partnerAuthUrl =
    '$partnerBaseUrl/api/Authentication/RequestMoblieCabinetApiToken';
