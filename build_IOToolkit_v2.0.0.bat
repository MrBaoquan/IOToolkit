cd IODevice
call build_IOToolkit.bat

set version=v2.0.0
cd ..
xcopy .\IOUI\%version%\IOToolkit .\%version%\IOToolkit\ /E /F /Y
xcopy .\IODevice\%version%\IOToolkit .\%version%\IOToolkit\ /E /F /Y

set env=Win64
set dst_dir_name=IOToolkit_Test_x64
xcopy .\IODevice\%version%\IOToolkit_Test_Win64 .\%version%\%dst_dir_name%\ /E /F /Y
xcopy .\%version%\IOToolkit\binaries\%env%\ExternalLibraries .\%version%\%dst_dir_name%\ExternalLibraries\ /E /F /Y
@rem xcopy .\%version%\IOToolkit\binaries\%env%\ExternalLibraries\Config .\%version%\%dst_dir_name%\ExternalLibraries\Config /E /F /Y
copy .\%version%\IOToolkit\binaries\%env%\IODevice.dll .\%version%\%dst_dir_name%\ /Y
copy .\%version%\IOToolkit\binaries\%env%\IODevice_C_Wrapper.dll .\%version%\%dst_dir_name%\ /Y
copy .\%version%\IOToolkit\binaries\%env%\IODevice_CSharp_Wrapper.dll .\%version%\%dst_dir_name%\ /Y

set env=Win32
set dst_dir_name=IOToolkit_Test_x32
xcopy .\IODevice\%version%\IOToolkit_Test_Win32 .\%version%\%dst_dir_name%\ /E /F /Y
xcopy .\%version%\IOToolkit\binaries\%env%\ExternalLibraries .\%version%\%dst_dir_name%\ExternalLibraries\ /E /F /Y
@rem xcopy .\%version%\IOToolkit\binaries\%env%\ExternalLibraries\Config .\%version%\%dst_dir_name%\ExternalLibraries\Config /E /F /Y
copy .\%version%\IOToolkit\binaries\%env%\IODevice.dll .\%version%\%dst_dir_name%\ /Y
copy .\%version%\IOToolkit\binaries\%env%\IODevice_C_Wrapper.dll .\%version%\%dst_dir_name%\ /Y

echo "Build Completed..."
pause