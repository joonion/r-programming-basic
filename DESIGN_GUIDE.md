# R 프로그래밍 기초 슬라이드 디자인 가이드

## 디자인 원칙

이 프로젝트의 슬라이드는 대학생과 대학원생이 강의실 화면과 개인 기기에서 모두 읽기 쉽도록 설계한다.

1. 한 슬라이드에는 한 가지 핵심 질문이나 개념을 둔다.
2. 제목, 핵심 개념, 설명, 코드, 실습 행동을 명확히 구분한다.
3. 밝은 배경과 높은 명암 대비를 유지한다.
4. 장식보다 정보의 순서와 정렬을 우선한다.
5. 긴 내용은 글자를 지나치게 줄이지 않고 여러 슬라이드로 나눈다.
6. 애니메이션과 전환 효과는 교육적 필요가 있을 때만 사용한다.
7. HTML과 PPTX는 같은 색상과 정보 구조를 사용하되 출력 형식의 차이를 인정한다.

## 색상 팔레트

| 역할 | 색상 | 용도 |
|---|---|---|
| 배경 | `#F8FAFC` | 기본 슬라이드 배경 |
| 기본 텍스트 | `#172033` | 제목과 본문 |
| 주 강조 | `#2563EB` | 제목선, 핵심 구조, 목록 표식 |
| 보조 강조 | `#0F766E` | 실습, 보조 개념 |
| 주의·경고 | `#B45309` | 경고, 점검, 주의문 |
| 코드 배경 | `#F1F5F9` | 코드 블록과 인라인 코드 |
| 구분선 | `#CBD5E1` | 표와 제목 구분선 |
| 보조 텍스트 | `#526077` | 각주, 부가 정보 |

한 슬라이드에서 주 강조색과 보조 강조색을 동시에 과도하게 사용하지 않는다. 경고색은 실제 주의가 필요한 내용에만 사용한다.

## 글꼴 체계

### RevealJS

- 한글 제목과 본문: `Pretendard Variable`, `Pretendard`
- 영문 fallback: `Inter`, `Segoe UI`
- 한글 fallback: `Noto Sans KR`, `Malgun Gothic`
- 코드: `JetBrains Mono`, `Cascadia Code`, `Consolas`

브라우저는 앞의 글꼴이 없으면 뒤의 글꼴을 순서대로 사용한다. 외부 웹 폰트를 내려받지 않으므로 오프라인 렌더링도 유지된다.

### PPTX

- 제목과 본문: `Pretendard`
- 코드: `JetBrains Mono`
- 영문 보조 정보: `Inter`

글꼴이 설치되지 않은 컴퓨터에서는 PowerPoint가 시스템 글꼴로 대체할 수 있다. 배포 환경에는 Pretendard와 JetBrains Mono 설치를 권장하며, 설치할 수 없다면 맑은 고딕과 Consolas 대체 결과를 확인한다.

## 슬라이드 유형별 작성 규칙

### 1. 표지 슬라이드

- YAML의 `title`과 `subtitle`을 사용한다.
- 제목은 한 문장으로 유지하고 불필요한 장식을 추가하지 않는다.
- 강사 정보가 확정되면 YAML의 `author`에 기록한다.

```yaml
---
title: "3차시: 벡터와 인덱싱"
subtitle: "R 기초 프로그래밍"
author: "강사명"
---
```

### 2. 장 구분 슬라이드

- 큰 흐름이 바뀌는 지점에서만 사용한다.
- 장 제목과 한 문장 설명만 배치한다.
- RevealJS에서는 `.section-divider` 클래스를 사용한다.

```markdown
## 데이터 점검에서 분석으로 {.section-divider}

검증한 데이터에서 분석 대상 샘플을 선택합니다.
```

PPTX에서 수동 편집이 필요할 때는 `Section Header` 레이아웃을 사용한다.

### 3. 학습목표 슬라이드

- 3~5개 목표를 행동 중심 문장으로 작성한다.
- `.learning-objectives` 클래스를 사용한다.
- 새로운 개념 설명을 섞지 않는다.

```markdown
## 오늘의 학습 목표 {.learning-objectives}

1. 벡터를 만들 수 있다.
2. 필요한 원소를 선택할 수 있다.
3. 기초 통계 함수를 적용할 수 있다.
```

### 4. 선수지식 슬라이드

- 현재 차시에 실제로 필요한 기능만 적는다.
- `.prerequisites` 클래스를 사용한다.

### 5. 개념 설명 슬라이드

- 제목이 핵심 결론을 말하도록 작성한다.
- 짧은 설명과 하나의 예제를 우선한다.
- 목록은 가능한 한 병렬적인 문장 구조로 작성한다.

### 6. 코드 설명 슬라이드

- 한 코드 블록은 화면 높이의 절반 정도를 목표로 한다.
- 코드와 설명이 길면 코드 작성과 결과 해석을 별도 슬라이드로 나눈다.
- 한 블록에서 하나의 새로운 문법만 강조한다.
- 인라인 코드는 짧은 함수명, 변수명, 연산자에만 사용한다.

### 7. 비교 슬라이드

- 기준이 명확하면 표를 사용한다.
- 설명이 두 흐름으로 나뉘면 Quarto `columns`를 사용한다.
- 셀마다 긴 문장을 넣지 않는다.

```markdown
:::: {.columns}
::: {.column width="50%"}
### 반복문

- 실행 과정을 직접 제어
:::
::: {.column width="50%"}
### 벡터화 연산

- 같은 계산을 한 번에 적용
:::
::::
```

PPTX에서는 `Two Content` 또는 `Comparison` 레이아웃을 사용한다.

### 8. 실습 슬라이드

- 제목을 `실습 1: ...` 형식으로 작성한다.
- 실습 목표, 실행할 코드, 확인할 결과의 순서를 유지한다.
- 학생의 행동은 “작성하세요”, “실행하세요”, “확인하세요”처럼 명령형으로 쓴다.
- RevealJS는 `실습-`으로 시작하는 슬라이드 ID를 자동으로 실습 유형으로 표시한다.
- 직접 클래스를 지정하려면 `.exercise`를 사용한다.

```markdown
## 실습 1: 벡터 만들기 {.exercise}
```

PPTX 수동 편집 시 `Exercise` 레이아웃을 사용한다.

### 9. 요약 슬라이드

- 새 내용을 추가하지 않는다.
- 핵심 내용 3~5개만 남긴다.
- `.summary` 클래스를 사용한다.

### 10. 종료 점검 슬라이드

- 학습목표와 직접 연결되는 질문을 사용한다.
- `.checkpoint` 클래스를 사용한다.
- 다음 차시는 마지막 한 줄로 제시한다.

## RevealJS와 PPTX의 차이

### RevealJS

- `slides/custom.scss`가 색상, 간격, 표, 코드, 인용문, footer, 슬라이드 번호를 제어한다.
- 기준 화면은 1600 × 900의 16:9 비율이다.
- 코드 블록은 높이가 지나치게 커지면 내부 스크롤을 사용한다.
- 전환 효과는 사용하지 않는다.
- `.learning-objectives`, `.prerequisites`, `.exercise`, `.summary`, `.checkpoint`, `.section-divider` 클래스를 지원한다.

### PPTX

- RevealJS의 CSS는 적용되지 않는다.
- `assets/r-programming-reference.pptx`의 슬라이드 마스터와 레이아웃을 사용한다.
- 제공 레이아웃: `Title Slide`, `Section Header`, `Title and Content`, `Two Content`, `Comparison`, `Code / Demonstration`, `Exercise`, `Title Only`, `Blank`, `Content with Caption`, `Picture with Caption`.
- Pandoc은 Markdown 구조에 따라 표준 레이아웃을 자동 선택한다. 교육용 추가 레이아웃은 PowerPoint에서 후편집할 때도 사용할 수 있다.
- HTML 전용 클래스는 PPTX에서 장식으로 재현되지 않을 수 있지만 제목, 본문, 코드, 표의 의미는 유지된다.

## 새로운 슬라이드를 추가할 때

1. `slides/NN_topic.qmd`처럼 차시 번호와 내용을 알 수 있는 파일명을 사용한다.
2. YAML에 구체적인 제목과 `R 기초 프로그래밍` 부제를 적는다.
3. 새 개념은 짧은 설명 → 실행 가능한 예제 → 연습 문제 순서로 소개한다.
4. 한 슬라이드가 코드 블록 두 개와 긴 목록을 동시에 포함하면 분할을 검토한다.
5. 표가 6행 또는 5열을 크게 넘으면 두 슬라이드로 나누거나 핵심 열만 표시한다.
6. 실습은 슬라이드와 `labs/`의 R 파일에서 같은 순서를 사용한다.
7. RevealJS와 PPTX를 모두 렌더링해 누락과 오버플로를 확인한다.

## PPTX reference 문서 다시 만들기

PowerPoint가 설치된 Windows 환경에서 다음 명령을 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File scripts/create_reference_pptx.ps1
```

스크립트는 `assets/r-programming-reference.pptx`를 다시 생성한다.

## 렌더링 명령어

프로젝트 전체:

```powershell
quarto render
```

개별 RevealJS:

```powershell
quarto render slides/03_vectors_and_indexing.qmd --to revealjs
```

개별 PPTX:

```powershell
quarto render slides/03_vectors_and_indexing.qmd --to pptx
```

렌더링 결과는 `_site/slides/`에 생성된다.

## 완료 전 확인

- 제목과 본문이 겹치지 않는가?
- 본문이 발표 화면에서 읽을 수 있는가?
- 코드가 화면 밖으로 넘치지 않는가?
- 표가 지나치게 작지 않은가?
- 한글과 코드 글꼴이 의도한 글꼴 또는 fallback으로 표시되는가?
- PPTX의 텍스트 상자가 슬라이드 밖으로 벗어나지 않는가?
- HTML과 PPTX의 제목, 코드, 표, 실습 지시문이 모두 남아 있는가?
- 슬라이드 유형별 강조색이 일관되는가?
