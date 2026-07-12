# R 프로그래밍 기초

프로그래밍 경험이 거의 없는 생물학 전공 대학원생을 위한 R 기초 강의자료입니다. Quarto Website를 강의 홈으로 사용하고, 각 차시의 강의자료는 RevealJS 슬라이드로 제공합니다.

## 프로젝트 구성

- `index.qmd`: 강의 홈과 전체 목차
- `slides/`: 차시별 RevealJS 슬라이드
- `labs/`: 차시별 R 실습 파일
- `data/`: 교육용 합성 데이터와 설명
- `assets/`: PPTX reference 문서
- `_quarto.yml`: Quarto Website 공통 설정
- `.github/workflows/publish.yml`: GitHub Pages 자동 배포 워크플로

## 로컬 렌더링

프로젝트 루트에서 다음 명령을 실행합니다.

```cmd
quarto render
```

렌더링 결과는 `_site` 폴더에 생성됩니다. `_site`와 `.quarto`는 로컬 빌드 산출물이므로 Git에 포함하지 않습니다.

## 최초 GitHub Pages 게시

자동 배포를 사용하기 전에 로컬에서 다음 명령을 최초 한 번 실행합니다.

```cmd
quarto render
quarto publish gh-pages
```

`quarto publish gh-pages`를 실행하면 게시 설정을 위한 `_publish.yml`이 생성될 수 있습니다. `_publish.yml`과 실행 결과 캐시인 `_freeze`는 Git에서 제외하지 않습니다.

## GitHub Actions 자동 배포

`.github/workflows/publish.yml`은 다음 경우에 실행됩니다.

- `main` 브랜치에 변경 사항을 push할 때
- GitHub의 Actions 화면에서 `workflow_dispatch`로 수동 실행할 때

워크플로는 Quarto 공식 Actions를 사용해 사이트를 렌더링하고 `gh-pages` 브랜치에 게시합니다.

- `actions/checkout@v4`
- `quarto-dev/quarto-actions/setup@v2`
- `quarto-dev/quarto-actions/publish@v2`

## GitHub 저장소 설정

자동 배포 전에 GitHub 저장소에서 다음 항목을 직접 확인합니다.

1. **Settings → Actions → General → Workflow permissions**로 이동합니다.
2. **Read and write permissions**를 선택하고 저장합니다.
3. **Settings → Pages**로 이동합니다.
4. GitHub Pages가 `gh-pages` 브랜치에서 게시되도록 설정됐는지 확인합니다.

워크플로는 `contents: write` 권한과 저장소의 `GITHUB_TOKEN`을 사용해 `gh-pages` 브랜치를 갱신합니다.

## 배포 파일 관리

다음 항목은 Git에서 제외합니다.

- `_site/`
- `.quarto/`
- `site_libs/`

다음 항목은 Git에서 제외하지 않습니다.

- `_freeze/`
- `_publish.yml`
- `.github/`

## 슬라이드 디자인

RevealJS와 PPTX 디자인 규칙 및 렌더링 방법은 [DESIGN_GUIDE.md](DESIGN_GUIDE.md)를 참고합니다.
