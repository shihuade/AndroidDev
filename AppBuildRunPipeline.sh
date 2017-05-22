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

}

runBuildAndRunApp()
{
    echo "***********************************"
    echo "  Build and run app ..."
    echo "  PackageName is ${PackageName}"
    echo "***********************************"

}


runMain()
{
    runInit

    runInstallApp

    sleep 2
    runUnInstallApp
}

runMain

