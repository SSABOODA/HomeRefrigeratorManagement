# 냉싸부 - 냉장고를 싸그리 부탁해

## 📱 앱 설명
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

## 🗓️ 프로젝트 기간
- 2023.09.25 ~ 23.10.21(4주) - 현재 업데이트 진행 중

## 👥 프로젝트 참여 인원
- 1명(개인 출시)

## 🔗 앱 스토어 링크
[냉싸부 - 냉장고를 싸그리 부탁해](https://apps.apple.com/kr/app/%EB%83%89%EC%8B%B8%EB%B6%80-%EB%83%89%EC%9E%A5%EA%B3%A0%EB%A5%BC-%EC%8B%B8%EA%B7%B8%EB%A6%AC-%EB%B6%80%ED%83%81%ED%95%B4/id6470002194)

## 🛠️ 사용된 프레임워크, 라이브러리, 디자인 패턴
- DGCharts
- FSCalendar
- IQKeyboardManager
- Realm
- Snapkit
- Toast
- Firebase
  - Analytics
  - Crashlytics
- MVVM(Bind 패턴)

## 🔍 구현 기능
- GET, POST 하는 뷰의 식품 데이터들은 모두 UICollectionViewDiffableDataSource를 사용하여 구현하습니다.
    - 데이터 소스를 제공하여 효율적으로 셀을 관리하였습니다.
    - 데이터 변경을 추적하고 snapshot 기반으로 한 식품 데이터 검색 애니메이션을 사용하여 UX를 향상시켰습니다.
- 식품을 등록하는 뷰는 UISheetPresentController기반으로 구현하였고, 이를 통해 사용자가 더욱 빠르게 식품을 등록하고 확인 및 숨김이 가능하도록 구현하였습니다.
- 식품 검색은 한글 '초성' 검색이 가능하도록 하여 DiffableDataSource의 애니메이션 기능을 활용하여 사용자 경험을 더욱 증가시켰습니다.
- FSCalendar 라이브러리를 사용해 유통기한이 임박한 식품을 나타내었습니다.
  - 유통기한이 임박한 날의 식품이 존재한다면, 아래에 UICollectionViewDiffableDataSource 기반으로 컬렉션뷰를 구현하였습니다.
  - 해당 식품 클릭 시 식품 이름 데이터를 활용해 Youtube 사이트를 WebView를 활용해 띄워 바로 해당 레시피를 검색할 수 있도록 구현했습니다.
- DGCharts 라이브러리를 활용해 현재 저장된 식품군의 카테고리별로 pieChart로 나타내도록하였습니다.
  - 가독성을 위해 pieChart 이외에도 아래 같은 정보를 tableView형식으로 나타내었습니다.
- 시스템 알림과 앱 내 알림의 on,off 상태을 연동해 사용자가 원하는 시간에 유통기한 임박 상품의 알림을 받을 수 있도록 구현하였습니다.
  - 시스템 알림 상태와 앱 내 알림 상태 연동은 NotificationCenter를 활용해 구현하였습니다.

## 📖 프로젝트 기획 및 기록
- [기획 및 작업 기록](https://thankful-gymnast-355.notion.site/1c2d64adac9c4c219347d7b6ca2287a2?pvs=4)
- [앱 출시 회고 블로그](https://ios-developer-hans.tistory.com/17)

## 🔥 이슈
### 1. 앱 내의 '알림 설정'과 시스템 설정의 '알림 설정' 동기화 문제
```
- 앱 최초 실행시 알림 허용 O
	- 시스템 알림 허용 O 상태
        - 앱 내 알림 허용 O -> 푸쉬 알림 O
        - 앱 내 알림 허용 X -> 푸쉬 알림 X
- 앱 최초 실행시 알림 허용 X
	- 시스템 알림 허용 X 상태
        - 앱 내 알림 허용 O -> 시스템 알림 허용 상태와 동기화 -> 앱 내 알림 상태 X
        - 앱 내 알림 허용 X -> 푸쉬 알림 X
```
#### 문제 상황
- 설정 뷰에 들어왔을 때 `UNUserNotificationCenter` 클래스의 `authorizationStatus` 속성을 통해 현재 알림 권한 상태 체크
- 사용자가 최초 알람을 허용을 한 뒤 시스템 설정에 가서 알림 상태를 Off로 했을 때 문제가 발생
- 푸쉬 알림은 더 이상 보내면 안되므로 앱 내에서도 Off 상태로 동기화를 해줘야하는 문제

하지만 viewWillApper에 알림 상태 권한을 체크하는 로직이 들어가 있었는데, 이는 사용자가 앱을 background상태로 한 뒤 다시 앱을 켜 foreground 상태로 돌린다 하더라도,
viewWillApper가 재실행되지 않아 시스템 알림 권한 설정 상태를 실시간으로 체크하지 못해 동기화하지 못하는 문제가 발생

#### 문제 해결
- sceneWillEnterForeground 메서드와, NotificationCenter 활용하여 해결
- 사용자가 다시 앱을 실행할 때마다, 즉 sceneWillEnterForeground 메서드가 실행될 때마다 권한 체크하여 SettingViewController에 알려줄 수 있으면 해결할 수 있다고 판단하였습니다.

```swift
// SceneDelegate.swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneWillEnterForeground(_ scene: UIScene) {
	NotificationCenter.default.post(
	    name: NSNotification.Name("permission"),
	    object: nil
        )
    }
}
```

```swift
// AlarmViewController.swift
final class AlarmViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        startAddObserver()
    }

    private func startAddObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkNotificationSetting),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
       )
    }

    @objc private func checkNotificationSetting(notification: NSNotification) {
        UserNotificationRepository.shared.checkPermission { [weak self] value in
            self?.setSwitchValue(UserDefaultsHelper.standard.permission)
        }
    }

    private func setSwitchValue(_ permission: Bool) {
        DispatchQueue.main.async { [weak self] in
            if permission {
                self?.switchView.setOn(permission, animated: true)
                self?.footerView.isHidden = !permission
	    } else {
		self?.switchView.setOn(permission, animated: true)
		self?.footerView.isHidden = !permission
            }
        }
    }
}
```

### 3. Realm과 DiffableDatasource를 사용했을 때 Delete 시 크래시 문제
### 4. DiffableDatasource의 검색 애니메이션을 구현할 때 한글 검색으로 할 경우 문제
문제 상황







