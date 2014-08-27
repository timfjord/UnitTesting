param([string]$command)

Function Bootstrap {
    if ( ${env:SUBLIME_TEXT_VERSION} -eq "3" ){
        write-output "installing sublime text 3"
        start-filedownload "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059%20x64.zip"
        write-output "installing Sublime%20Text%20Build%203059%20x64.zip"
        7z.exe x "Sublime%20Text%20Build%203059%20x64.zip" -o"C:\st" > $null
    }elseif ( ${env:SUBLIME_TEXT_VERSION} -eq "2" ){
        write-output "installing sublime text 2"
        start-filedownload "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.zip"
        write-output "installing Sublime%20Text%202.0.2%20x64.zip"
        7z.exe x "Sublime%20Text%202.0.2%20x64.zip" -o"C:\st" > $null
    }

    mkdir "C:\st\Data\Packages\${env:PACKAGE}" -force > $null
    copy * -recurse -force "C:\st\Data\Packages\${env:PACKAGE}"
    if ( ${env:TAG} -eq $null ){
        $TAG = "master"
    }else{
        $TAG = ${env:TAG}
    }
    if(!(Test-Path -Path "C:\st\Data\Packages\UnitTesting")){
        git clone -q --branch=$TAG https://github.com/randy3k/UnitTesting.git "C:\st\Data\Packages\UnitTesting"
    }
}

Function RunTests {
    C:\st\Data\Packages\UnitTesting\sbin\run.ps1 "${env:PACKAGE}"
}

switch ($command){
    "bootstrap" { Bootstrap }
    "run_tests" { RunTests }
}