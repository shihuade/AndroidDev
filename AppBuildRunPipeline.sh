#!/bin/bash

runInit()
{
    PackageName="com.example.huade.myfirstapp"
    ApkFile="app/build/outputs/apk/app-debug.apk"
    AVDTarget="Pixel_API_23"

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
    echo "******************************************"
    echo "  check gradlew tasks for this project... "
    echo "    ./gradlew tasks"
    echo "*******************************************"
    ./gradlew tasks

    #clean/build app
    echo "***********************************"
    echo "  gradlew clean previous build..."
    echo "    ./gradlew clean"
    echo "***********************************"
    ./gradlew clean

    #clean/build app
    echo "***********************************"
    echo "  gradlew  build..."
    echo "    ./gradlew build"
    echo "***********************************"
    ./gradlew build

    sleep 1
    #install and uninstall
    echo "***********************************"
    echo "  gradlew  install Debug..."
    echo "    ./gradlew installDebug"
    echo "***********************************"
    ./gradlew installDebug

    sleep 2
    echo "***********************************"
    echo "  gradlew  uninstall Debug..."
    echo "    ./gradlew uninstallDebug"
    echo "***********************************"
    ./gradlew uninstallDebug

    echo "****************************************"
    echo "  gradlew  pipeline script passed!...   "
    echo "    clean/build/install/uninstall"
    echo "****************************************"
}

runAVDInstall()
{
     echo "****************************************"
     echo "  Install app on emulator...   "
     echo "     emulator @${AVDTarget}"
     echo "****************************************"

     emulator @${AVDTarget}

     echo "****************************************"
     echo "  uninstall app on emulator...   "
     echo "     adb uninstall ${PackageName}"
     echo "****************************************"
     adb uninstall ${PackageName}

     echo "****************************************"
     echo "  install app on emulator...   "
     echo "     adb install ${PackageName}"
     echo "****************************************"
     adb install ${ApkFile}
}


runMain()
{
    runInit

    runInstallApp

    sleep 2
    runUnInstallApp

    sleep 2
    runBuildAndRunApp

    sleep 2
    runAVDInstall
}

runMain

