@echo off
chcp 65001 > nul
color 0F

echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║                   XML 설정파일 테스트                            ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.

echo 샘플 XML 설정파일을 사용한 엑셀 파일 생성을 시작합니다...
echo.

:: output 디렉토리 생성
if not exist "output" mkdir output

echo 📊 XML 스타일 테스트 중...
echo.
echo 포함되는 시트:
echo   ✓ 주문_목록 (헤더: 중앙정렬/파란배경/검은테두리)
echo   ✓ 고객_목록 (바디: 좌측정렬/노란배경/회색테두리)
echo   ✓ 목차 시트
echo.
echo 테스트 내용:
echo   ▶ Alignment (정렬): 헤더 center, 바디 left
echo   ▶ Border (테두리): 헤더 검은색, 바디 회색
echo   ▶ Font (폰트): 맑은 고딕, 헤더 12px 굵게, 바디 11px 일반
echo   ▶ Fill (배경): 헤더 파란색, 바디 노란색
echo.

:: XML 파일을 사용한 엑셀 파일 생성 실행
node src/index.js -x resources/queries-sample.xml

if %errorlevel% equ 0 (
    echo.
    echo ╔══════════════════════════════════════════════════════════════════╗
    echo ║                        생성 완료!                               ║
    echo ╚══════════════════════════════════════════════════════════════════╝
    echo.
    echo 📁 생성된 파일:
    echo    - 매출집계_2024_yyyymmddhhmmss.xlsx
    echo    - 매출집계_2024_목차_yyyymmddhhmmss.xlsx
    echo.
    echo 📋 XML vs JSON 비교 확인:
    echo    ▶ JSON 파일: test-sample-orders.bat 실행
    echo    ▶ XML 파일: 방금 생성된 파일
    echo    ▶ 동일한 스타일이 적용되었는지 확인해주세요!
    echo.
    echo 🎨 스타일 확인 사항:
    echo    ✓ 헤더 셀: 중앙정렬, 파란배경, 흰글자, 검은테두리
    echo    ✓ 데이터 셀: 좌측정렬, 노란배경, 검은글자, 회색테두리
    echo    ✓ 컬럼 너비: 자동 조정 (최소 10, 최대 30)
    echo.
    echo output 폴더를 열까요? (Y/N)
    set /p open_folder=
    if /i "%open_folder%"=="Y" (
        explorer "output"
    )
) else (
    echo.
    echo ❌ 엑셀 파일 생성에 실패했습니다.
    echo.
    echo 가능한 원인:
    echo   1. 데이터베이스 연결 실패
    echo   2. SampleDB 데이터베이스가 존재하지 않음
    echo   3. XML 파싱 오류
    echo.
    echo 해결 방법:
    echo   1. SQL Server Management Studio에서 다음 스크립트를 순서대로 실행:
    echo      - resources/create_sample_tables.sql
    echo      - resources/insert_sample_data.sql
    echo   2. resources/config.json에서 DB 연결정보 확인
    echo   3. resources/queries-sample.xml 파일 구문 확인
    echo.
)

echo.
echo 💡 XML과 JSON 스타일 차이 비교 테스트:
echo    1. test-sample-xml.bat (XML 파일)
echo    2. test-sample-orders.bat (JSON 파일)
echo    두 파일을 실행하여 스타일이 동일하게 적용되는지 확인하세요!
echo.
pause 