module.exports = {
  getCellularInfo: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CellularInfo', 'getCellularInfo', []);
  }
};
