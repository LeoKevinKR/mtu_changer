# MTU_Changer
 
1. netsh interface ipv4 show interface   -- 랜카드 상태 색인 표를 확인

2. netsh interface ip set global minmtu=352   -- mtu 최저값 변경 설정

3. netsh interface ipv4 set subinterface "7" mtu=400 store=persistent
store=active 하면 재부팅시 원상복구됨

4. 원복은 netsh interface ipv4 set subinterface "7" mtu=1500 store=persistent
