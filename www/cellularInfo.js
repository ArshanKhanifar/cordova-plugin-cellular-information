module.exports = {
  getCellularInformation: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CellularInformation', 'getCellularInformation', []);
  }
};
