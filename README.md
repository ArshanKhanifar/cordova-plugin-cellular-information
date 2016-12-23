### Cellular-Network-Info
This plugin is a mix of the two [cordova-plugin-networkinterface](https://github.com/salbahra/cordova-plugin-networkinterface) and the [cordova-plugin-sim](https://github.com/pbakondy/cordova-plugin-sim) plugins. 
The usage is similar to that of [cordova-plugin-sim](https://github.com/pbakondy/cordova-plugin-sim), except the exposed object is `CellularInfo` instead of `sim`, and `getCellularInfo` is used instead of `getSimInfo`.

Additionally, the `getIPAddress` method from [cordova-plugin-networkinterface](https://github.com/salbahra/cordova-plugin-networkinterface) is exposed here as another method of the `CellularInfo` object. Its usage is the exact same thing.


    document.addEventListener("deviceready", onDeviceReady, false);

    function onDeviceReady() {
      window.plugins.CellularInfo.getCellularInfo(successCallback, errorCallback); // from cordova-plugin-sim 
      window.plugins.CellularInfo.getIPAddress(function (ip) { // from cordova-plugin-networkinterface
          addInfo('ip Address', ip);
      });
    }

    function successCallback(result) {
      console.log(result);
    }

    function errorCallback(error) {
      console.log(error);
    }

### Difference with cordova-plugin-networkinterface

The `getIPAddress()` method from this plugin has a small difference with the one from [cordova-plugin-networkinterface](https://github.com/salbahra/cordova-plugin-networkinterface). On ios devices, this method returns the cellular ip address if the device is connected to a cellular network, whereas on cordova-plugin-networkinterface, this method only returns the wifi ip address.
