echo "Removing existing release notes"
rm release-notes.txt release-notes.json
echo "Applying patch for package.json"
sed -i '' '/rn-ldk/d' ./package.json
sed -i '' 's/"patches": "patch -p1 < scripts\/rn-ldk.patch",/"patches":/g' ./package.json
rm -fr node_modules
echo "Re-installing node_modules"
npm i
echo "Deleting lightning-ldk-wallet.ts content"
cp scripts/maccatalystpatches/lightning-ldk-wallet.ts class/wallets/lightning-ldk-wallet.ts
echo "Updating Podfile"
cd ios && pod update && cd ..
echo "Remove Settings.bundle from Xcode project as its only meant for iOS"
rm -rf /ios/Settings.bundle
sed -i '' '/Settings.bundle/d' ios/BlueWallet.xcodeproj/project.pbxproj
echo ""
echo "NOTE: rn-dlk is not currently compatible with Mac Catalyst."