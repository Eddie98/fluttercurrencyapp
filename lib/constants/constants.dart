const keyPeanutLogin = '_key_peanut_login';
const keyPeanutToken = '_key_peanut_token';
const keyPartnerLogin = '_key_partner_login';
const keyPartnerToken = '_key_partner_token';

const invalidLogPass = 'Invalid login or password';
const someWentWrong = 'Something went wrong';

const defaultHorPadding = 16.0;

const testAuthData = {'login': 20234561, 'password': 'ladevi31'};

const testDefaultCurrencyPairs = <String>[
  'EURUSD',
  'GBPUSD',
  'USDJPY',
  'USDCHF',
  'USDCAD',
  'AUDUSD',
  'NZDUSD'
];
const testDefaultPeriod = MapEntry('H1', Duration(hours: 1));
const testDefaultFromToMap = {'from': 1479860023, 'to': 1480066860};

const allCurrenciesList = <String>[
  'EURUSD',
  'GBPUSD',
  'USDJPY',
  'USDCHF',
  'USDCAD',
  'AUDUSD',
  'NZDUSD'
];
const allPeriodsMap = <String, Duration>{
  'H1': Duration(hours: 1),
  'H4': Duration(hours: 4),
  'D1': Duration(days: 1),
  'W1': Duration(days: 7),
  'M1': Duration(days: 30),
  'M5': Duration(days: 30 * 5),
  'M15': Duration(days: 30 * 15),
  'M30': Duration(days: 30 * 30),
};

const String peanutBaseUrl = 'https://peanut.ifxdb.com/api/ClientCabinetBasic';
const String peanutAuthUrl = '$peanutBaseUrl/IsAccountCredentialsCorrect';
const String peanutGetAccountInfoUrl = '$peanutBaseUrl/GetAccountInformation';
const String peanutGetLastFourNumbersPhoneUrl =
    '$peanutBaseUrl/GetLastFourNumbersPhone';

const String partnerBaseUrl = 'https://client-api.contentdatapro.com';
const String partnerAuthUrl =
    '$partnerBaseUrl/api/Authentication/RequestMoblieCabinetApiToken';
const String partnerGetAnalyticSignalsUrl =
    '$partnerBaseUrl/clientmobile/GetAnalyticSignals';

const String promotionsBaseUrl =
    'https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc?wsdl';
