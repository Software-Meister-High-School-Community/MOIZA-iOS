# 모이자!

## ✨ Summary
전국 소프트웨어마이스터고등학교의 학생들과 졸업생, 재학생의 소통을 연결하는 SNS

<br>

## 📸 Screenshots
![promotion](https://user-images.githubusercontent.com/74440939/213873575-f2d7e09a-9360-45b8-a5db-47c38d97530a.png)

## 📚 Tech Stack
- Swift
- PinLayout, FlexLayout
- RxSwift
- RxFlow
- ReactorKit
- Clean Architecture
- Tuist

<br>

## 🏃‍♀️ Run Project
```bash
$ curl -Ls https://install.tuist.io | bash
$ brew install make

$ make generate
$ xed .
```

## ⭐️ Key Function
### 첫화면
- 로그인, 회원가입 화면으로 이동할 수 있습니다.

<img src="https://user-images.githubusercontent.com/74440939/213874201-18a29f6b-12f5-47c9-b105-035c44a37e9a.png" width="150">

### 회원가입
- 이용약관 동의를 받습니다.
- 학생 구분(재학생, 졸업생), 이름, 학교, 학년, 반, 번호, 이메일을 입력받습니다.
- 아이디와 비밀번호를 입력받습니다.
- 재학생일 경우 회원가입이 완료되고, 졸업생일 경우 졸업생 인증으로 넘어갑니다.
- 졸업생 인증은 앨범에서 이미지 선택, 혹은 촬영을 통해 업로드합니다.
- 업로드 완료 시 회원가입이 완료됩니다.

<div>
  <img src="https://user-images.githubusercontent.com/74440939/213874244-c7a5d565-77fb-402e-9d46-d548a8199d24.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874248-f210c14d-ca6d-4c53-afe2-65a5b7b36094.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874269-e36d4b11-f134-4ad9-8779-bf1bebac18b9.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874278-de37d883-f86c-48d2-a4de-371ec8e497d2.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874250-ddc6d06e-cab5-48af-9fa8-74577a43fc56.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874267-c3093f48-a260-42fa-a0f0-d6b33417ec9e.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874257-e3c20cc2-13bd-4126-811a-7733dfbe4cc0.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874277-17ff6836-1746-4132-b3d7-321563840fe5.png" width="150">
</div>

### 로그인
- 아이디와 비밀번호를 입력받아 로그인합니다.

<img src="https://user-images.githubusercontent.com/74440939/213874439-223f68dc-7847-4438-aed8-898c0846013f.png" width="150">

### 아이디 찾기
- 잃어버린 이메일의 인증을 하고 완료 시 아이디를 찾을 수 있습니다.

<div>
  <img src="https://user-images.githubusercontent.com/74440939/213874468-f521cb71-7edf-4410-b80a-e2d4fc1729c6.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874470-ef36452e-919c-4c5a-b777-f731a6ff65dc.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874471-a4f415ab-1cc3-48e9-84bb-5bf14181db24.png" width="150">
</div>

### 비밀번호 찾기
- 비밀번호를 잃어버린 아이디를 입력하여 해당 아이디의 이메일 인증을 진행합니다.
- 인증이 완료될 시 비밀번호를 재등록할 수 있습니다.

<div>
  <img src="https://user-images.githubusercontent.com/74440939/213874530-20d31400-0d5d-4825-92d1-81dfe7ba263b.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874537-bd3d279a-c3b3-409d-a892-ae8d57565457.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874547-9a188e78-0ef3-48f1-80f0-a3a005aa2389.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874551-7e899206-e017-42c3-984d-4a121684fe5c.png" width="150">
</div>

### 게시글 탭
- 탭을 처음 열 때 카테고리를 선택해 해당 카테고리의 게시글을 볼 수 있습니다.
- 정렬 버튼을 눌러 게시글을 정렬할 수 있습니다.
- 게시글을 선택하면 게시글의 상세 내용, 댓글을 볼 수 있습니다.

<div>
  <img src="https://user-images.githubusercontent.com/74440939/213874654-2a3887d9-7c9e-4f29-b235-19d9e9dafec9.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874712-68d760de-1f89-4eab-8f85-a448750e9ef5.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213875682-39081fcb-afd1-464f-9e19-2c2ca0006c78.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874758-a23fc1dc-ceab-4455-9e58-62cd366f9dc7.png" width="150">
</div>

### 게시글 검색
- 키워드를 입력하여 검색할 수 있습니다.
- 최신에 검색한 키워드를 저장해놓습니다.
- 검색할 시 유저와 게시물이 결과물로 나옵니다.
- 정렬 버튼을 눌러 결과물을 정렬할 수 있습니다.

<div>
  <img src="https://user-images.githubusercontent.com/74440939/213874814-c132a678-305f-4e7b-a2d4-595adff340bb.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874810-ab8690ca-2906-4666-b592-37f78461e7c0.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213874813-cf79c96d-e6f3-4c60-8953-6d80e7e3ceff.png" width="150">
</div>

### 공지사항 탭
- 가장 최신의 공지를 볼 수 있습니다.
- 유저에게 온 알람을 볼 수 있습니다.
- 전체 공지 리스트를 볼 수 있습니다.
- 공지를 눌러 공지의 자세한 내용을 볼 수 있습니다.

<div>
  <img src="https://user-images.githubusercontent.com/74440939/213874975-fbc62b48-05f3-41c2-8a7c-58c5d33a610b.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213875006-a9340692-995b-445f-b3fd-ea63761c8691.png" width="150">
  <img src="https://user-images.githubusercontent.com/74440939/213875067-19f3cea1-8f3d-47db-b299-89fb1bedea78.png" width="150">
</div>

### 마이페이지 
- 유저의 정보를 볼 수 있습니다.
- 유저가 작성한 게시물 리스트를 볼 수 있습니다.
- 유저가 작성한 게시물 리스트를 정렬할 수 있습니다.

<img src="https://user-images.githubusercontent.com/74440939/213875618-9b80b1a9-001a-4126-ab6a-977577af66fa.png" width="150">