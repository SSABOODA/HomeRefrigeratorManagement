# 냉싸부 - 냉장고를 싸그리 부탁해
<img src="https://github.com/SSABOODA/HomeRefrigeratorManagement/assets/69753846/096ebcbc-863b-46e1-9634-06b092c08861" height="100" width="100">

## 프로젝트 소개
<p align="center" width="100%">
  <img src="https://github.com/SSABOODA/HomeRefrigeratorManagement/assets/69753846/8ffedb94-b078-49f3-ad64-79426b8c723d" width="100%">
</p>

### 앱 스토어 링크
[냉싸부 - 냉장고를 싸그리 부탁해](https://apps.apple.com/kr/app/%EB%83%89%EC%8B%B8%EB%B6%80-%EB%83%89%EC%9E%A5%EA%B3%A0%EB%A5%BC-%EC%8B%B8%EA%B7%B8%EB%A6%AC-%EB%B6%80%ED%83%81%ED%95%B4/id6470002194)

### 앱 소개
냉장고에 쌓여있던 음식들의 유통기한을 편하게 관리하고 소비또는 재구매할 수 있도록 도와주는 앱입니다.

- 식품 구매일자, 유통기한 정보 저장
- 캘린더를 통한 유통기한 별 식품의 레시피 검색
- 현재 남아있는 식품이 있다면 빠르게 '소비하기' 기능을 통해 소비하거나 모자란 식품이 있다면 구매 확인
- 차트를 통해 현재 보관 식품의 종류별 현황을 파악
- 유통기한이 지났거나, 임박한 상품이 있다면 푸쉬 알림을 통해 관리 유도

### 프로젝트 기간
- 2023.09.25 ~ 23.10.21(4주) - 현재 업데이트 진행 중

### 프로젝트 참여 인원
- 1명(개인) - 출시

<br>
<br>

## 사용된 기술 스택
- **Framework**
`UIKit`
- **Library**
`Realm`, `Snapkit`,
`DGCharts`, `FSCalendar`, `IQKeyboardManager`, `Toast`
, `Firebase(Analytics, Crashlytics)`
- **Design Pattern**
`MVVM(+Bind)`, `Repository Pattern`, `Singleton Pattern`
- **Etc**
`Code Base UI`, `Modern CollectionView`, `CompositionalLayout`

<br>
<br>

구현 기능
- 모든 View는 **Modern Collection View**를 사용하여 UI를 구성하였습니다.
- **UICollectionViewDiffableDataSource**의  사용하여 검색 시 애니메이션 효과를 가진 데이터 변경이 일어나도록 구현했습니다.
- **UnicodeScalar**값을 활용해 한글 **초성 검색**이 가능하도록하여 데이터 변경 사항 애니메이션을 적극 활용하도록 구현하였습니다.
- **FSCalendar** 라이브러리를 Custom하여 event를 식품 icon으로 대체하여 **사용자 친화적 UI**를 구현하도록하였습니다.
- **DGCharts** 라이브러리를 활용해 저장된 식품 카테고리 비율로 **pieChart**로 나타내어 체계적 관리를 할 수 있도록 하였습니다.
- **NotificationCenter**를 사용하여 시스템 알림 설정과 인앱 알림 설정 상태 **동기화**를 구현하였습니다.
- **NotificationCenter**관련 코드는 **Repository Pattern**을 활용하여 코드 재사용성과 가독성을 증가시켰습니다.
 
<br>
<br>

## 프로젝트 기획 및 기록
- [기획 및 작업 기록](https://thankful-gymnast-355.notion.site/1c2d64adac9c4c219347d7b6ca2287a2?pvs=4)
- [앱 출시 회고 블로그](https://ios-developer-hans.tistory.com/17)

<br>
<br>

## Trouble Shooting
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

<br>

### 2. Realm과 DiffableDatasource를 사용했을 때 Delete 시 크래시 문제

#### 문제 상황
- 식품을 등록하는 메인 뷰는 현재 `DiffableDatasource` 기반으로 CollectionView로 구현되어 있고, Realm Database를 같이 사용하고 있습니다.  
- 문제는 Realm에서 데이터를 삭제했을 때 발생했다. `DiffableDatasource` 는 뷰의 갱신을 위해 뷰의 현재 데이터 상태를 스냅샷을 통해 보관하고 있는데 아래 예시처럼 해당 데이터가 삭제되면서 문제가 발생했습니다.
```
DiffableDatasource - diff -> DiffableDatasource
Realm<Object>1               Realm<Object>1
Realm<Object>2               Realm<Object>2
Realm<Object>3 -> delete     Realm<Object>4
Realm<Object>4
```
데이터를 삭제 한 직후 바로 snapshot을 통해 데이터를 재구성하게되면 Realm에서 예외처리 오류가 발생했습니다.
```
Terminating app due to uncaught exception 'RLMException', reason: 'Object has been deleted or invalidated.'
terminating with uncaught exception of type NSException
```
`RLMException` 에러가 발생했고 Object가 삭제되었거나, 유효하지 않다는 내용의 에러입니다.
Realm에서 데이터를 삭제한 뒤 해당 객체를 참조하거나 출력만 하려해도 에러가 발생하게됩니다.

#### 문제 해결
- 데이터를 삭제하는 ViewModel에서 Closure를 통해 데이터 삭제 여부를 전달하는 방식

데이터가 삭제되었다면 snapshot 메서드가 있는 뷰컨트롤러로 데이터 삭제 여부를 completionHandler를 통해 전달하였고, 
snapshot을 실행하는 시점에 분기처리를 통해 직접 snapshot item에 delete 메서드를 통해 동기화 시켜주는 방식으로 해결했습니다.

- 데이터 삭제 Scene - ViewController
```swift
final class FoodDetailManagementViewController: BaseViewController {
    let viewModel = FoodDetailManagementViewModel()

    @objc func deleteButtonTapped() {
        showAlertAction2(
            preferredStyle: .alert,
            title: Constant.AlertText.deleteAlertTitleMessage
        ) {} _: {
            self.viewModel.deleteData()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
```

- 데이터 삭제 Scene - ViewModel
```swift
final class FoodDetailManagementViewModel {
    var isDelete = Observable(false)
    var completionHandler: ((Bool) -> Void)?

    func deleteData() {
        isDelete.value = true
	completionHandler?(isDelete.value)
    }
}
```

- 데이터를 삭제하기 전 데이터를 넘겨줄 ViewController
```swift
final class FoodManagementViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        performQuery(searchText: "", storageType: currentStorageType)
    }

    private func performQuery(
        searchText: String,
        sortType: SortType = .expiration,
        storageType: Constant.FoodStorageType
    ) {

    let item = viewModel.filterFoodData(
        query: searchText,
        sortType: sortType,
        storageType: storageType
    )
        
    guard let item else { return }
    updateEmptyView()

    var snapshot = NSDiffableDataSourceSnapshot<Section, Food>()
    snapshot.appendSections([.main])
    snapshot.appendItems(item)

    // relam 데이터 삭제시 snapshot 처리
    if let deleteFood = viewModel.deleteFoodData, !deleteFood.isInvalidated {
        snapshot.deleteItems([deleteFood])
        dataSource.apply(snapshot, animatingDifferences: true)
        RealmTableRepository.shared.delete(object: deleteFood)
        viewModel.filteredFoodDataArray = viewModel.filteredFoodData?.toArray()
            updateEmptyView()
    }
    dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FoodManagementViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = FoodDetailManagementViewController()
        guard let filteredFoodDataArray = self.viewModel.filteredFoodDataArray else { return }
        let food = filteredFoodDataArray[indexPath.item]
        nextVC.viewModel.food = food
        nextVC.viewModel.completionHandler = { [weak self] isDelete in
            guard let weakSelf = self else {return }
            if isDelete {
                weakSelf.viewModel.deleteFoodData = food
                weakSelf.view.makeToast(Constant.ToastMessage.foodDeleteSuccessMessage)
            }
        }
        transition(viewController: nextVC, style: .push)
    }
}
```

- ViewModel
```swift
final class FoodManagementViewModel {
    var deleteFoodData: Food?
}
```

<br>

### 3. DiffableDatasource의 검색 애니메이션을 구현할 때 한글 검색으로 할 경우 문제
#### 문제 상황
`DiffableDatasource`를 사용하여 컬렉션뷰를 구성하였고, 식품 검색을 할 때 한글로 검색 시 애니메이션을 효과를 사용할 수 없는 문제가 발생했습니다.

애플의 예제에서는 영어를 기준으로 검색하였을 때는 애니메이션 효과가 잘 실행되었고 그것을 기반으로 한글 또한 같은 로직을 사용하면 문제 없을 것이라고 생각하고 접근했습니다.
하지만 한글의 경우 입력을 시작할 때 처음은 초성으로 시작하는데 초성에 해당하는 데이터는 당연히 없으므로 빈 데이터를 보여준 뒤 그 다음 글자가 완성되었을 때 해당 데이터를 뷰에 
그리는 순간 애니메이션 효과가 나타나지 않는 문제가 있었습니다.

#### 문제 해결
이 문제를 해결하기 위해서는 생각했던 방법은 식품을 검색할 때 초성 검색이 가능하도록 하는 것이었습니다.
예를 들어 '고구마'라는 식품을 검색할 때 'ㄱㄱㅁ' 를 검색어로 입력했을 때 '고구마'가 검색된다면 애니메이션 효과가 적용될 수 있을 것이고 사용자 UX또한 효과적으로 올릴 수 있다는 생각을 했습니다.

문제 해결을 위해 작성했는 코드를 살펴보겠습니다.
- 한글의 자음, 모음을 분리하는 메서드
```swift
import Foundation

let korean = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

func getInitialConsonants(word: String) -> String {
    
    var result = ""
    
    for char in word {
        let scalar = char.unicodeScalars.first!
        if scalar >= "\u{AC00}" && scalar <= "\u{D7A3}" {
            let index = Int((scalar.value - 0xAC00) / 28 / 21)
            result.append(korean[index])
        } else {
            result.append(char)
        }
    }

    return result
}

func isChosung(word: String) -> Bool {
    var isChosung = false
    for char in word {
        if 0 < korean.filter({ $0.contains(char)}).count {
            isChosung = true
        } else {
            isChosung = false
            break
        }
    }
    return isChosung
}
```
- 검색 query
```swift
import Foundation

final class FoodRegisterListViewModel {
    var foodIconInfo = Observable(Constant.FoodConstant.foodIconInfo)
    var isSave = Observable(false)
    
    var completionHandler: ((Bool) -> Void)?
  
    func filterInitialConsonant(with searchText: String) -> [FoodModel] {
        let foodIconData = Constant.FoodConstant.foodIconInfo
        if searchText.isEmpty {
            return foodIconData
        }
        
        let text = searchText.trimmingCharacters(in: .whitespaces)
        let isChosungCheck = isChosung(word: text)

        let filteredData = foodIconData.filter({
            if isChosungCheck {
                return ($0.name.contains(text) || getInitialConsonants(word: $0.name).contains(text))
            } else {
                return $0.name.contains(text)
            }
        })
        return filteredData
    }
}
```

## 💡 추후 업데이트 예정 기능
- MapKit을 이용한 근처 식료품점 확인
- 레시피 크롤링, API를 활용한 저장 기능
- 차트 다변화 및 상세화
