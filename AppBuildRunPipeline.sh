#!/bin/bash

runInit()
{
    PackageName="com.example.huade.myfirstapp"
    ApkFile="app/build/outputs/apk/app-debug.apk"

}

runInstallApp()
{
    echo "***********************************"
    echo "  Installing app ..."
    echo "  ApkFile is ${ApkFile}"
    echo "***********************************"
    adb install ${ApkFile}
    if [ $? -eq 0 ]
    then
        echo "***********************************"
        echo "  Installing app successfully!"
        echo "***********************************"
    else
        echo "***********************************"
        echo "  Installing app failed!"
        echo "***********************************"
    fi
}

runUnInstallApp()
{
    echo "***********************************"
    echo "  Uninstalling app ..."
    echo "  PackageName is ${PackageName}"
    echo "***********************************"

    adb uninstall ${PackageName}
    if [ $? -eq 0 ]
    then
        echo "***********************************"
        echo "  Uninstalling app successfully!"
        echo "***********************************"
    else
        echo "***********************************"
        echo "  Uninstalling app failed!"
        echo "***********************************"
    fi
}

BasicAdbCommand()
{
    echo " list all packages installed on device"
    adb shell pm list package

    #install app step
    #push, and install via pm command
    adb push /Users/../xx/../MyFirstApp/app/build/outputs/apk/app-debug.apk /data/local/tmp/com.example.huade.myfirstapp
    adb shell pm install -r "/data/local/tmp/com.example.huade.myfirstapp"

    #run app with am start command
    adb shell am start -n "com.example.huade.myfirstapp/com.example.huade.myfirstapp.MainActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER

}

runBuildAndRunApp()
{
    echo "***********************************"
    echo "  Build and run app ..."
    echo "  PackageName is ${PackageName}"
    echo "***********************************"

    #gradew command to build
    #reference: https://developer.android.google.cn/studio/build/building-cmdline.html?hl=zh-cn

#check all gradlew tasks
./gradlew tasks
#clean/build app
./gradlew build
./gradlew clean
#install and uninstall
./gradlew install/uninstall

}


runMain()
{
    runInit

    runInstallApp

    sleep 2
    runUnInstallApp
}

runMain

