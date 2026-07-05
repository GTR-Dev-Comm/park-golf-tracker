# 진행기록 트래커 — 배포 가이드 (상세)

이 폴더에는 파일이 3개 있습니다.
- `index.html` — 앱 전체 (이것만 배포하면 됩니다)
- `supabase-schema.sql` — 데이터베이스 설정용 SQL
- `README.md` — 이 문서

전체 순서: **① Supabase에 데이터베이스 만들기 → ② index.html에 접속 정보 3개 입력 → ③ GitHub에 올리기 → ④ Vercel에 배포 → ⑤ 접속 테스트**

---

## ① Supabase에 데이터베이스 만들기

1. 브라우저에서 https://supabase.com 접속 → 오른쪽 위 **Start your project** 클릭 (계정 없으면 GitHub 계정으로 로그인 가능)
2. 로그인 후 대시보드에서 **New project** 클릭
3. 아래 항목 입력
   - **Name**: 아무 이름 (예: `park-golf-tracker`)
   - **Database Password**: 자동 생성되거나 직접 입력 — 이 비밀번호는 따로 메모해두세요 (나중에 안 씁니다만 잊어버리면 안 됨)
   - **Region**: `Northeast Asia (Seoul)` 선택 (한국에서 쓰니까 가장 가까운 지역)
4. **Create new project** 클릭 → 1~2분 정도 기다리면 프로젝트가 생성됩니다.

### SQL 실행하기

5. 프로젝트가 열리면 왼쪽 사이드바에서 **SQL Editor** 아이콘 클릭 (`>_` 모양 아이콘)
6. **New query** 클릭
7. 이 폴더의 `supabase-schema.sql` 파일을 텍스트 편집기(메모장 등)로 열어서 **전체 내용을 복사**
8. SQL Editor 입력창에 붙여넣기
9. 오른쪽 아래(또는 상단) **Run** 버튼 클릭 (단축키 Ctrl+Enter)
10. 하단에 `Success. No rows returned` 같은 메시지가 뜨면 성공입니다.
    - 왼쪽 사이드바 **Table Editor** 클릭해서 `categories`, `items` 테이블이 생겼는지, `categories`에 4개 행(일정/할일/미팅일정/진행사항)이 들어있는지 확인해보세요.

### 접속 정보(URL, API 키) 복사하기

11. 왼쪽 사이드바 아래쪽 톱니바퀴 **Project Settings** 클릭
12. 왼쪽 메뉴에서 **API** 클릭
13. 이 화면에서 두 가지를 복사해서 메모장 같은 곳에 잠깐 붙여두세요.
    - **Project URL** — `https://xxxxxxxxxxxx.supabase.co` 형태
    - **Project API keys** 항목의 **anon / public** 키 — `eyJhbGci...` 로 시작하는 긴 문자열

---

## ② index.html에 접속 정보 입력하기

1. `index.html` 파일을 텍스트 편집기(메모장, VSCode 등)로 엽니다.
2. `Ctrl+F`로 `SUPABASE_URL` 검색 — 아래 3줄을 찾습니다.

```js
const SUPABASE_URL = "https://YOUR-PROJECT.supabase.co";
const SUPABASE_ANON_KEY = "YOUR-ANON-KEY";
const APP_PASSWORD = "changeme"; // 원하는 비밀번호로 바꾸세요
```

3. 다음과 같이 바꿉니다.
   - `"https://YOUR-PROJECT.supabase.co"` → ①-13에서 복사한 **Project URL**로 교체 (따옴표는 그대로 두기)
   - `"YOUR-ANON-KEY"` → ①-13에서 복사한 **anon public 키**로 교체
   - `"changeme"` → 앱 접속할 때 입력할 비밀번호로 원하는 대로 변경 (예: `"gtr2026"`)
4. 저장합니다.

---

## ③ GitHub에 저장소 만들고 올리기

### 방법 A — 웹사이트에서 직접 업로드 (git 명령어 몰라도 됨, 추천)

1. https://github.com 로그인 (기존 `gtr-dev-comm` 계정 사용 가능)
2. 오른쪽 위 **+** 버튼 → **New repository**
3. **Repository name** 입력 (예: `park-golf-tracker`), Public/Private 아무거나 선택 → **Create repository**
4. 생성된 저장소 화면에서 **uploading an existing file** 링크 클릭
5. `index.html`, `supabase-schema.sql`, `README.md` 3개 파일을 끌어다 놓기 (드래그 앤 드롭)
6. 아래 **Commit changes** 클릭

### 방법 B — 명령어로 올리기 (터미널 익숙하신 경우)

```bash
cd park-golf-tracker-service
git init
git add .
git commit -m "init"
git branch -M main
git remote add origin https://github.com/gtr-dev-comm/park-golf-tracker.git
git push -u origin main
```

---

## ④ Vercel에 배포하기

1. https://vercel.com 접속 → GitHub 계정으로 로그인
2. 대시보드에서 **Add New...** → **Project** 클릭
3. 방금 만든 GitHub 저장소(`park-golf-tracker`)를 찾아서 **Import** 클릭
4. 설정 화면에서:
   - **Framework Preset**: `Other` (또는 자동으로 감지되는 대로 두어도 됨 — 빌드 명령이 필요 없는 정적 파일이라 상관없습니다)
   - 나머지는 기본값 그대로 둡니다.
5. **Deploy** 클릭 → 30초~1분 정도 기다립니다.
6. 배포가 끝나면 `https://park-golf-tracker-xxxx.vercel.app` 같은 주소가 나옵니다. 이게 실제 서비스 주소입니다.

---

## ⑤ 접속 테스트

1. 방금 나온 Vercel 주소를 브라우저에서 열어봅니다.
2. 비밀번호 입력 화면이 뜨면 ②-3에서 설정한 비밀번호 입력 → **입장**
3. 달력 화면이 뜨고 "새 건" 버튼이 보이면 정상입니다.
4. 테스트로 아무 건이나 하나 등록해보고, Supabase **Table Editor → items** 테이블에 그 데이터가 실제로 들어갔는지 확인해보면 완전히 확인됩니다.

이 주소 + 비밀번호를 공유하실 1~2명에게 전달하시면 됩니다. 스마트폰 브라우저에서도 그대로 접속 가능합니다 (반응형으로 만들어져 있음).

---

## 이후 수정하고 싶을 때

- 화면/기능을 바꾸고 싶으면 `index.html`을 수정한 뒤, GitHub 저장소에 다시 업로드(또는 `git push`)하면 Vercel이 자동으로 재배포합니다.
- 데이터 구조(테이블에 새 항목 추가 등)를 바꾸고 싶으면 Supabase **SQL Editor**에서 `alter table` 명령을 실행하면 됩니다.
- 막히는 부분 있으면 화면 캡처해서 보여주시면 바로 도와드릴게요.
