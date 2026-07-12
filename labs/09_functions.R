# 9차시 실습: 함수 작성하기

# 이름:
# 날짜:


# 실습 준비: 샘플 메타데이터 불러오기 -------------------------------

input_path <- "data/sample_metadata.csv"
file.exists(input_path)

sample_metadata <- read.csv(input_path)
head(sample_metadata)


# 실습 1: 첫 번째 함수 작성하기 --------------------------------------

# 세포 수를 천 개 단위로 변환하는 함수를 정의하세요.
to_thousands <- function(cell_count) {
  result <- cell_count / 1000
  return(result)
}

# 단일 값으로 함수를 호출하세요.
to_thousands(1240)
to_thousands(1520)

# 반환값을 변수에 저장하세요.
control_count_k <- to_thousands(1240)
control_count_k

# 함수 호출만 했을 때와 반환값을 다시 저장했을 때를 비교하세요.
example_counts <- c(1350, 980, 1240)
sort(example_counts)
example_counts

example_counts <- sort(example_counts)
example_counts

# TODO: round()로 아래 값의 소수 첫째 자리까지 계산한 뒤
# TODO: 같은 변수 이름에 다시 저장하고 결과를 확인하세요.
example_ratio <- 83.746

# 벡터를 입력하여 결과를 확인하세요.
to_thousands(c(1240, 1385, 1090))

# TODO: mito_percent를 100으로 나누어 비율로 변환하는
# TODO: to_fraction() 함수를 작성하고 단일 값과 벡터로 시험하세요.


# 실습 2: 여러 입력을 받는 함수 만들기 -------------------------------

# 필터링 후 남은 세포 비율을 계산하는 함수를 정의하세요.
calculate_retention <- function(raw_count, filtered_count) {
  retention <- filtered_count / raw_count
  return(retention)
}

# 위치에 따라 인자를 전달하세요.
calculate_retention(1500, 1200)

# 이름을 적어 인자를 전달하세요.
calculate_retention(
  raw_count = 1500,
  filtered_count = 1200
)

# 이름을 모두 적으면 순서를 바꾸어도 됩니다.
calculate_retention(
  filtered_count = 1200,
  raw_count = 1500
)

# TODO: 두 숫자의 차이를 계산하는 calculate_difference() 함수를
# TODO: 작성하고 이름이 있는 인자로 호출하세요.


# 실습 3: 기본값이 있는 인자 사용하기 -------------------------------

# 세포 수 기준 통과 여부를 확인하는 함수를 정의하세요.
passes_cell_count <- function(cell_count, min_cells = 1200) {
  result <- cell_count >= min_cells
  return(result)
}

# 기본 기준을 사용하세요.
passes_cell_count(1240)
passes_cell_count(1090)

# 호출할 때 기준을 바꾸세요.
passes_cell_count(1240, min_cells = 1300)

# 벡터 전체에 함수를 적용하세요.
passes_cell_count(sample_metadata$cell_count)

# TODO: mito_percent가 기준 미만인지 확인하는 passes_mito() 함수를
# TODO: 작성하세요. max_mito의 기본값은 8입니다.


# 실습 4: 데이터 프레임 열에 함수 적용하기 --------------------------

# 세포 수 단위를 변환한 열을 추가하세요.
sample_metadata$cell_count_k <-
  to_thousands(sample_metadata$cell_count)

# 세포 수 기준 통과 여부 열을 추가하세요.
sample_metadata$passes_cell_count <-
  passes_cell_count(sample_metadata$cell_count)

sample_metadata[, c(
  "sample_id",
  "cell_count",
  "cell_count_k",
  "passes_cell_count"
)]

# TODO: to_fraction()으로 mito_fraction 열을 추가하세요.


# 실습 5: 여러 QC 기준을 하나의 함수로 묶기 -------------------------

# 이 함수의 수치는 R 함수 학습을 위한 예시입니다.
# 실제 QC 기준은 데이터와 실험 맥락을 검토하여 정합니다.
passes_qc <- function(
  cell_count,
  median_genes,
  mito_percent,
  min_cells = 1200,
  min_genes = 2000,
  max_mito = 8
) {
  result <-
    cell_count >= min_cells &
    median_genes >= min_genes &
    mito_percent < max_mito

  return(result)
}

# 단일 샘플 값으로 함수를 시험하세요.
passes_qc(
  cell_count = 1240,
  median_genes = 2180,
  mito_percent = 4.2
)

# 데이터 프레임의 열을 입력하세요.
qc_result <- passes_qc(
  cell_count = sample_metadata$cell_count,
  median_genes = sample_metadata$median_genes,
  mito_percent = sample_metadata$mito_percent
)

qc_result

# 기준을 더 엄격하게 바꾸어 결과를 비교하세요.
strict_qc_result <- passes_qc(
  cell_count = sample_metadata$cell_count,
  median_genes = sample_metadata$median_genes,
  mito_percent = sample_metadata$mito_percent,
  min_cells = 1300,
  min_genes = 2200,
  max_mito = 6
)

qc_result
strict_qc_result

# TODO: 기본 기준과 엄격한 기준을 각각 통과한 샘플 수를 계산하세요.


# 실습 6: 결과 레이블 함수 만들기 ------------------------------------

# 논리형 값을 QC 레이블로 변환하는 함수를 정의하세요.
label_qc <- function(passed_qc) {
  label <- ifelse(passed_qc, "pass", "review")
  return(label)
}

qc_labels <- label_qc(qc_result)
qc_labels

# 결과를 데이터 프레임에 추가하세요.
sample_metadata$qc_result <- qc_result
sample_metadata$qc_label <- qc_labels

sample_metadata[, c("sample_id", "qc_result", "qc_label")]

# TODO: TRUE이면 "included", FALSE이면 "excluded"를 반환하는
# TODO: label_inclusion() 함수를 작성하세요.


# 실습 7: 결측값을 처리하는 함수 만들기 -----------------------------

# doublet_rate를 세 가지 레이블로 변환하는 함수를 정의하세요.
label_doublet_rate <- function(doublet_rate, max_rate = 4) {
  label <- ifelse(
    is.na(doublet_rate),
    "missing",
    ifelse(doublet_rate <= max_rate, "pass", "review")
  )

  return(label)
}

doublet_labels <- label_doublet_rate(sample_metadata$doublet_rate)
doublet_labels

sample_metadata$doublet_label <- doublet_labels
sample_metadata[, c("sample_id", "doublet_rate", "doublet_label")]

# 다른 기준을 사용해 결과를 비교하세요.
label_doublet_rate(sample_metadata$doublet_rate, max_rate = 3)

# TODO: NA이면 "missing", 값이 8 미만이면 "pass",
# TODO: 그 밖에는 "review"인 label_mito() 함수를 작성하세요.


# 실습 8: 입력 자료형 확인하기 ---------------------------------------

# 숫자형 입력만 허용하는 함수를 정의하세요.
to_thousands_checked <- function(cell_count) {
  if (!is.numeric(cell_count)) {
    stop("cell_count는 숫자형이어야 합니다.")
  }

  result <- cell_count / 1000
  return(result)
}

# 올바른 입력으로 시험하세요.
to_thousands_checked(1240)
to_thousands_checked(c(1240, 1520))

# 다음 의도적 오류는 한 줄씩 직접 실행해 메시지를 확인하세요.
# 전체 스크립트 실행을 방해하지 않도록 주석 처리했습니다.
# to_thousands_checked("1240")

# TODO: calculate_retention()의 두 입력이 모두 숫자형인지
# TODO: 확인하는 코드를 함수 안에 추가해 보세요.


# 실습 9: 함수 결과 검증하기 -----------------------------------------

# 결과를 쉽게 예상할 수 있는 값으로 확인하세요.
stopifnot(to_thousands(1000) == 1)
stopifnot(calculate_retention(100, 80) == 0.8)
stopifnot(passes_cell_count(1200) == TRUE)
stopifnot(passes_cell_count(1199) == FALSE)
stopifnot(label_qc(TRUE) == "pass")
stopifnot(label_qc(FALSE) == "review")

# 조건이 모두 TRUE이면 아무것도 출력되지 않는 것이 정상입니다.

# TODO: 직접 작성한 to_fraction()에 대해
# TODO: 예상 결과를 확인하는 stopifnot()을 추가하세요.


# 실습 10: 함수 결과 정리하고 저장하기 -------------------------------

# 저장할 열을 선택하세요.
function_results <- sample_metadata[, c(
  "sample_id",
  "cell_count",
  "cell_count_k",
  "qc_result",
  "qc_label",
  "doublet_rate",
  "doublet_label"
)]

function_results

# 결과를 CSV 파일로 저장하세요.
dir.create("results", showWarnings = FALSE)
output_path <- "results/function_results.csv"

write.csv(function_results, output_path, row.names = FALSE)
file.exists(output_path)

# 저장 결과를 다시 불러와 확인하세요.
saved_results <- read.csv(output_path)
saved_results
str(saved_results)


# 마무리 연습: 샘플 포함 여부 함수 만들기 ---------------------------

# 다음 조건을 모두 만족하면 TRUE를 반환하는 is_analysis_sample()
# 함수를 작성하세요.
# - passed_qc가 TRUE
# - doublet_rate가 결측값이 아님
# - doublet_rate가 max_doublet 이하
# max_doublet의 기본값은 4입니다.

# TODO: is_analysis_sample() 함수를 작성하세요.
# TODO: 단일 값으로 TRUE, FALSE, 결측값 상황을 시험하세요.
# TODO: 데이터 프레임 열을 입력하여 analysis_sample 열을 만드세요.
# TODO: 함수를 적용한 결과를 새 CSV 파일로 저장하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 작성한 함수가 정의된 뒤에 호출되는지 확인하세요.
# TODO: 함수의 검증 코드가 모두 통과하는지 확인하세요.
# TODO: 파일을 저장하세요.
