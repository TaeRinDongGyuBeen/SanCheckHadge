## 📝 코드 컨벤션
1. **Class / Struct** 정의
    - Class / Struct의 정의는 UpperCamelCase를 사용합니다.
    ```swift
    class FindIdViewModel: ObservableObject { ... }
    struct FindIdModel: Codable { ... }
    ```
2. **변수 및 함수**정의
    - 변수와 함수의 정의는 lowerCamelCase를 사용합니다.
    ```swift
    func getFacilities(userUUID: String) { ... }
    var facilityName: String = ""
    ```
3. **주석**활용
    - View는 **// - MARK :** 주석을 통해 영역을 구분합니다.

## 📌 Git Guide
> Issue -> 브랜치 생성 -> Pull 받은 후 작업 -> Commit -> Pull -> Push -> PR -> Merge

0. 새로운 작업 진행 전, Pull 하고 진행.
1. Issue는 기능 단위로 생성.
2. Issue에 관한 Commit과 Push는 본인 브랜치로 진행.
3. PR은 모든 작업 완료 후 보내기.

> 브랜치명 예제 (ex.이슈번호 10)

- 브랜치는 각 `feat/이슈번호-큰기능명/세부기능명`으로 생성합니다.
- ex. feat/#10-MapView/UI

<br>

> 커밋 컨벤션
```
[CHORE] 코드 수정, 내부 파일 수정, 주석
[FEAT] 새로운 기능 구현
[ADD] Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시, 에셋 추가
[FIX] 버그, 오류 해결
[DEL] 쓸모없는 코드 삭제
[DOCS] README나 WIKI 등의 문서 개정
[MOVE] 프로젝트 내 파일이나 코드의 이동
[RENAME] 파일 이름 변경이 있을 때 사용합니다
[REFACTOR] 전면 수정이 있을 때 사용합니다
[INIT] 프로젝트 생성
```
