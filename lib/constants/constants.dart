const keyPeanutLogin = '_key_peanut_login';
const keyPeanutToken = '_key_peanut_token';
const keyPartnerLogin = '_key_partner_login';
const keyPartnerToken = '_key_partner_token';

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

// TODO: method
const String prtnerGetAnalyticSignals =
    '$partnerBaseUrl/clientmobile/GetAnalyticSignals/20234 561?tradingsystem=3&pairs=GBPJPY,EURJPY&from=1479860023&to=1480066860';
