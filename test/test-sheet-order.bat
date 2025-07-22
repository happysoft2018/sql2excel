@echo off
chcp 65001 > nul
color 0F

echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║                    시트 순서 확인 테스트                          ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.

echo 목차 시트가 맨 왼쪽에 위치하는지 확인합니다.
echo.

:: output 디렉토리 생성
if not exist "output" mkdir output

echo 📊 시트 순서 테스트용 엑셀 생성 중...
echo.

:: XML 파일로 테스트
node src/index.js -x resources/queries-sample.xml

if %errorlevel% equ 0 (
    echo.
    echo ╔══════════════════════════════════════════════════════════════════╗
    echo ║                      시트 순서 테스트 완료!                        ║
    echo ╚══════════════════════════════════════════════════════════════════╝
    echo.
    echo 📁 생성된 파일에서 시트 순서를 확인하세요:
    echo.
    echo 📋 예상 시트 순서:
    echo    1. 목차          (파란색 탭, 맨 왼쪽)
    echo    2. 주문_목록     (두 번째)
    echo    3. 고객_목록     (세 번째)  
    echo    4. 주문_상세     (네 번째)
    echo.
    echo 🔍 확인 방법:
    echo.
    echo 1. 생성된 Excel 파일을 Microsoft Excel에서 열기
    echo 2. 화면 하단의 시트 탭 순서 확인
    echo 3. '목차' 탭이 맨 왼쪽에 있고 파란색인지 확인
    echo 4. 목차 시트를 클릭해서 내용 확인
    echo.
    echo 📊 시트 탭 특징:
    echo    ✓ 목차 시트: 파란색 탭으로 구분
    echo    ✓ 데이터 시트: 기본 색상
    echo    ✓ 순서: 목차 → 데이터 시트들 (알파벳/한글 순)
    echo.
    echo 🔧 기술적 구현:
    echo    - workbook.worksheets 배열 재정렬
    echo    - 각 시트의 id 및 orderNo 재설정
    echo    - 시트 탭 색상으로 목차 구분
    echo.
    echo 💡 문제 해결:
    echo.
    echo 만약 목차가 맨 왼쪽에 없다면:
    echo    1. Excel을 완전히 닫고 다시 열기
    echo    2. 파일을 다른 이름으로 저장 후 다시 열기
    echo    3. Excel 캐시 문제일 수 있음
    echo.

    echo output 폴더를 열까요? (Y/N)
    set /p open_folder=
    if /i "%open_folder%"=="Y" (
        explorer "output"
    )
) else (
    echo.
    echo ❌ 엑셀 파일 생성에 실패했습니다.
    echo    데이터베이스 연결을 확인하세요.
    echo.
)

echo.
echo 🔄 다른 테스트:
echo    - test-toc-links.bat     : 목차 링크 기능 테스트
echo    - test-sample-orders.bat : 대용량 시트 순서 테스트
echo.
pause 