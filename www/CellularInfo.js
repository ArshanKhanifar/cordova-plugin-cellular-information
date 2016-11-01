module.exports = {
  getCellularInfo: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CellularInfo', 'getCellularInfo', []);
  },
  getIPAddress: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CellularInfo', 'getIPAddress', []);
  },
  getPhoneNumber: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CellularInfo', 'getPhoneNumber', []);
  }
};
