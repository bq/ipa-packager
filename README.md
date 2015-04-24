ipa-packager
===

This script packages a signed application into an IPA that contains the SwiftSupport folder with libswiftCore*.dylib.
This is needed to deploy an app made with Swift into the AppStore

#Usage

###Run the script:
	sh package_ipa.sh /path/to/signed/app /output/ipa/path


###Requirements
- OSX Mavericks or Yosemite
- Xcode 6
- Xcode command line tools

###License
This script is distributed in terms of LGPL license. See http://www.gnu.org/licenses/lgpl.html for more details.
