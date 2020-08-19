@echo off
echo === MTU Toggle for Chrome Korean by LK ===

::get minmtu. 352~576
for /f "tokens=2 delims=:" %%A in ('netsh interface ip show global ^| find "최소 MTU"') do (set tmp1=%%A)
set minmtu=%tmp1:~+1%

:begin
netsh interface ipv4 show interface | find /V "disconnected"
set /p idx=MTU를 변경할 색인 번호[Q:종료]:

if /i "%idx%"=="q" goto end
if "%idx%"=="1" (
  echo Warning: 1번 색인은 부적절합니다.
  goto begin
)

for /f "tokens=2 delims=:" %%B in ('netsh interface ipv4 show interface "%idx%" ^| find "MTU"') do (set tmp2=%%B)
set mtu=%tmp2:~+1,-3%

echo. 

if "%mtu%"=="1500" (
  echo Set interface #%idx% to MTU=400
  if not %minmtu% == 352 (
    echo Change minmtu to 352
    netsh interface ip set global minmtu=352 store=active
  )
  netsh interface ipv4 set subinterface "%idx%" mtu=400 store=active
) else (
  echo Set interface #%idx% to MTU=1500
  netsh interface ipv4 set subinterface "%idx%" mtu=1500 store=active
)

goto begin

:end
