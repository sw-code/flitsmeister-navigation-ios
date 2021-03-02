
<div align="center">
  <img src="https://github.com/flitsmeister/flitsmeister-navigation-ios/blob/master/.github/splash-image-ios.png" alt="Flitsmeister Navigation iOS Splash">
</div>
<br>

The Flitsmeister Navigation SDK for iOS is built on a fork of the [Mapbox Navigation SDK v0.21](https://github.com/flitsmeister/flitsmeister-navigation-ios/tree/v0.21.0) which is build on top of the [Mapbox Directions API](https://www.mapbox.com/directions) and contains logic needed to get timed navigation instructions.

With this SDK you can implement turn by turn navigation in your own iOS app while hosting your own Map tiles and Directions API.

# Why have we forked

1. Mapbox decided to put a closed source component to their navigation SDK and introduced a non open source license. Flitsmeister wants an open source solution.
2. Mapbox decided to put telemetry in their SDK. We couldn't turn this off without adjusting the source.
3. We want to use the SDK without paying Mapbox for each MAU and without Mapbox API keys.

All issues are covered with this SDK. 

# What have we changed

- Removed EventManager and all its references, this manager collected telemetry data which we don't want to send
- Updated [Mapbox SDK](https://github.com/mapbox/mapbox-gl-native-ios) from version 4.3 to 5.3
- Added optional config parameter in NavigationMapView constructor to customize certain properties like route line color

# Getting Started

If you are looking to include this inside your project, you have to follow the the following steps:

## Carthage

To install Mapbox Navigation using [Carthage](https://github.com/Carthage/Carthage/) v0.35 or above:

1. Go to your [Mapbox account dashboard](https://account.mapbox.com/) and create an access token that has the `DOWNLOADS:READ` scope. **PLEASE NOTE: This is not the same as your production Mapbox API token. Make sure to keep it private and do not insert it into any Info.plist file.** Create a file named `.netrc` in your home directory if it doesn’t already exist, then add the following lines to the end of the file:
   ```
   machine api.mapbox.com
     login mapbox
     password PRIVATE_MAPBOX_API_TOKEN
   ```
   where _PRIVATE_MAPBOX_API_TOKEN_ is your Mapbox API token with the `DOWNLOADS:READ` scope. 

1. _(Optional)_ Clear your Carthage caches:
   ```bash
   rm -rf ~/Library/Caches/carthage/ ~/Library/Caches/org.carthage.CarthageKit/binaries/{MapboxAccounts,MapboxCommon-ios,MapboxNavigationNative,mapbox-ios-sdk-dynamic}
   ```

1. Create a [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#github-repositories) with the following dependency:
   ```cartfile
   github "flitsmeister/flitsmeister-navigation-ios"
   ```

1. Run `./Carthage/Checkouts/mapbox-navigation-ios/scripts/wcarthage.sh bootstrap --platform iOS --cache-builds --use-netrc`. (wcarthage.sh is a temporary replacement for `carthage` to work around [a linker error in Xcode 12](https://github.com/Carthage/Carthage/issues/3019).)

1. Follow the rest of [Carthage’s iOS integration instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos). Your application target’s Embed Frameworks build phase should include `MapboxNavigation.framework`, `MapboxCoreNavigation.framework`, `MapboxNavigationNative.framework`, `MapboxCommon.framework`, and `MapboxAccounts.framework`.

### Using Swift Package Manager

The MapboxNavigation framework [does not yet support Swift Package Manager](https://github.com/mapbox/mapbox-navigation-ios/issues/2629) either on the command line or in Xcode. However, if you are building a user interface from scratch, you can [install just the MapboxCoreNavigation framework using SPM](./custom-navigation.md#using-swift-package-manager). 

# Getting Help

- **Have a bug to report?** [Open an issue](https://github.com/flitsmeister/flitsmeister-navigation-ios/issues). If possible, include the version of Flitsmeister Services, a full log, and a project that shows the issue.
- **Have a feature request?** [Open an issue](https://github.com/flitsmeister/flitsmeister-navigation-ios/issues/new). Tell us what the feature should do and why you want the feature.

## <a name="sample-code">Sample code

A demo app is currently not available, so no sample code yet. Please check the Mapbox repository or documentation for examples.

In order to see the map or calculate a route you need your own Maptile and Direction services.

# License

Code is [licensed](LICENSE.md) under MIT and ISC. 
ISC is meant to be functionally equivalent to the MIT license.
