현재 Quarto Website + RevealJS 프로젝트에 GitHub Actions 기반 자동 배포를 설정하라.

요구사항은 다음과 같다.

1. 기본 브랜치는 `main`이다.
2. 게시 대상은 GitHub Pages의 `gh-pages` 브랜치이다.
3. `.github/workflows/publish.yml`을 생성한다.
4. Quarto 공식 Actions를 사용한다.

   * `actions/checkout@v4`
   * `quarto-dev/quarto-actions/setup@v2`
   * `quarto-dev/quarto-actions/publish@v2`
5. `main` 브랜치에 push할 때 자동 실행되도록 한다.
6. `workflow_dispatch`를 추가하여 GitHub에서 수동 실행도 가능하게 한다.
7. 워크플로에 `contents: write` 권한을 지정한다.
8. 현재 프로젝트에 R 코드가 포함되어 있으므로 `_quarto.yml`에 다음 설정이 있는지 확인하고, 없다면 추가한다.

```yaml
execute:
  freeze: auto
```

9. `_site`와 `.quarto`는 `.gitignore`에 추가하되 `_freeze`, `_publish.yml`, `.github`는 제외하지 않는다.
10. 기존 `_quarto.yml` 설정과 사이트 구조는 손상시키지 않는다.
11. 생성하거나 수정한 파일의 내용을 제시한다.
12. 실제로 가능한 범위에서 YAML 문법과 Quarto 프로젝트 구성을 검증한다.
13. 로컬에서 최초 한 번 실행해야 하는 다음 명령도 README에 안내한다.

```cmd
quarto render
quarto publish gh-pages
```

14. GitHub 저장소에서 사용자가 직접 설정해야 하는 다음 항목을 README에 기록한다.

* Settings → Actions → General → Workflow permissions
* Read and write permissions 선택
* Settings → Pages에서 `gh-pages` 브랜치 게시 여부 확인
