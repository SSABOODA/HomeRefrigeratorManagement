# 냉싸부 - 냉장고를 싸그리 부탁해

## 앱 설명
<p align="center" width="100%">
  <img src="https://github.com/SSABOODA/HomeRefrigeratorManagement/assets/69753846/6ad97490-9992-449e-9610-2d07cc8dee36" width="20%">
  <img src="https://github.com/SSABOODA/HomeRefrigeratorManagement/assets/69753846/ab24ae04-0b79-4807-88c2-f750fd0b5873" width="20%">
  <img src="https://github.com/SSABOODA/HomeRefrigeratorManagement/assets/69753846/2afb9333-f612-40d6-a678-7c90b5561e7b" width="20%">
  <img src="https://github.com/SSABOODA/HomeRefrigeratorManagement/assets/69753846/d3f50e7a-3e8b-4bc7-b5e3-13b81d88cdef" width="20%">
</p>

냉장고에 쌓여있던 음식들의 유통기한을 편하게 관리하고 소비또는 재구매할 수 있도록 도와주는 앱입니다.

- 식품 구매일자, 유통기한 정보 저장가능
- 캘린더를 통한 유통기한 별 식품의 레시피 검색가능
- 현재 남아있는 식품이 있다면 빠르게 '소비하기' 기능을 통해 소비하거나 모자란 식품이 있다면 구매 확인
- 차트를 통해 현재 보관 식품의 종류별 현황을 파악가능
- 유통기한이 지났거나, 임박한 상품이 있다면 푸쉬 알림을 통해 관리 유도

## 앱 스토어 링크
[냉싸부 - 냉장고를 싸그리 부탁해](https://apps.apple.com/kr/app/%EB%83%89%EC%8B%B8%EB%B6%80-%EB%83%89%EC%9E%A5%EA%B3%A0%EB%A5%BC-%EC%8B%B8%EA%B7%B8%EB%A6%AC-%EB%B6%80%ED%83%81%ED%95%B4/id6470002194)

## 사용된 프레임워크, 라이브러리
- DGCharts
- FSCalendar
- IQKeyboardManager
- Realm
- Snapkit
- Toast
- Firebase
  - Analytics
  - Crashlytics

## 프로젝트 기획 및 기록
- [기획 및 작업 기록](https://thankful-gymnast-355.notion.site/1c2d64adac9c4c219347d7b6ca2287a2?pvs=4)
- [앱 출시 회고 불로그](https://ios-developer-hans.tistory.com/17)

## 이슈
1. 앱 내의 '알림 설정'과 시스템 설정의 '알림 설정' 동기화 문제
2. Realm과 DiffableDatasource를 사용했을 때 Delete 시 크래시 문제
3. DiffableDatasource의 검색 애니메이션을 구현할 때 한글 검색으로 할 경우 문제
문제 상황







