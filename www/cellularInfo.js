module.exports = {
  getSimInfo: function(successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CellularInformation', 'getCellularInformation', []);
  }
};
