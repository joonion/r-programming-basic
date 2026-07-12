# 8차시 실습: 반복 처리와 벡터화 연산

# 이름:
# 날짜:


# 실습 준비: 샘플 메타데이터 불러오기 -------------------------------

input_path <- "data/sample_metadata.csv"
file.exists(input_path)

sample_metadata <- read.csv(input_path)
head(sample_metadata)


# 실습 1: 벡터의 값을 하나씩 반복하기 -------------------------------

cell_counts <- sample_metadata$cell_count

# 각 세포 수를 순서대로 출력하세요.
for (cell_count in cell_counts) {
  print(cell_count)
}

# 각 세포 수를 천 개 단위로 계산하여 출력하세요.
for (cell_count in cell_counts) {
  cell_count_k <- cell_count / 1000
  print(cell_count_k)
}

# TODO: sample_metadata$sample_id의 값을 하나씩 출력하세요.


# 실습 2: 위치 번호를 반복하기 ---------------------------------------

# cell_counts의 위치 번호를 확인하세요.
seq_along(cell_counts)

# 위치 번호와 해당 위치의 값을 함께 출력하세요.
for (index in seq_along(cell_counts)) {
  print(index)
  print(cell_counts[index])
}

# TODO: 위치 번호를 사용해 sample_id와 cell_count를
# TODO: 같은 순서로 하나씩 출력하세요.


# 실습 3: 반복 결과를 벡터에 저장하기 -------------------------------

# 입력과 같은 길이의 숫자형 결과 벡터를 준비하세요.
cell_count_k_loop <- numeric(length(cell_counts))

# 각 계산 결과를 같은 위치에 저장하세요.
for (index in seq_along(cell_counts)) {
  cell_count_k_loop[index] <- cell_counts[index] / 1000
}

cell_count_k_loop
length(cell_count_k_loop)

# 결과를 데이터 프레임의 새 열로 추가하세요.
sample_metadata$cell_count_k_loop <- cell_count_k_loop
head(sample_metadata)

# TODO: mito_percent에 100을 나눈 결과를 반복문으로 계산하여
# TODO: mito_fraction_loop에 저장하세요.


# 실습 4: 반복문 안에서 조건 사용하기 -------------------------------

# 문자형 결과 벡터를 준비하세요.
cell_count_labels_loop <- character(length(cell_counts))

# 각 세포 수에 따라 레이블을 저장하세요.
for (index in seq_along(cell_counts)) {
  if (cell_counts[index] >= 1200) {
    cell_count_labels_loop[index] <- "pass"
  } else {
    cell_count_labels_loop[index] <- "review"
  }
}

cell_count_labels_loop

# 데이터 프레임에 결과를 추가하여 원본 값과 함께 확인하세요.
sample_metadata$cell_count_label_loop <- cell_count_labels_loop
sample_metadata[, c("sample_id", "cell_count", "cell_count_label_loop")]

# TODO: mito_percent가 8 미만이면 "pass", 아니면 "review"인
# TODO: mito_labels_loop 벡터를 반복문으로 만드세요.


# 실습 5: 여러 열의 같은 행을 함께 처리하기 -------------------------

# 각 행의 여러 QC 값을 함께 확인하여 논리형 결과를 저장하세요.
qc_result_loop <- logical(nrow(sample_metadata))

for (row_index in seq_len(nrow(sample_metadata))) {
  enough_cells <- sample_metadata$cell_count[row_index] >= 1200
  enough_genes <- sample_metadata$median_genes[row_index] >= 2000
  low_mito <- sample_metadata$mito_percent[row_index] < 8

  qc_result_loop[row_index] <-
    enough_cells && enough_genes && low_mito
}

qc_result_loop

# 결과를 데이터 프레임에 추가하세요.
sample_metadata$qc_result_loop <- qc_result_loop
sample_metadata[, c("sample_id", "qc_result_loop")]

# 이 실습의 수치는 조건식 학습을 위한 예시입니다.
# 실제 QC 기준은 데이터와 실험 맥락을 검토하여 정합니다.


# 실습 6: 산술 계산을 벡터화하기 -------------------------------------

# 반복문으로 만든 결과와 같은 계산을 한 줄로 작성하세요.
cell_count_k_vectorized <- cell_counts / 1000
cell_count_k_vectorized

# 두 결과가 같은지 확인하세요.
identical(cell_count_k_loop, cell_count_k_vectorized)

# 데이터 프레임에 벡터화 결과를 추가하세요.
sample_metadata$cell_count_k_vectorized <- cell_count_k_vectorized

# TODO: mito_percent를 100으로 나누는 계산을 벡터화하여
# TODO: mito_fraction_vectorized에 저장하세요.
# TODO: 반복문 결과와 identical()로 비교하세요.


# 실습 7: 조건식을 벡터화하기 ---------------------------------------

# 여러 QC 조건을 벡터 연산으로 계산하세요.
qc_result_vectorized <-
  sample_metadata$cell_count >= 1200 &
  sample_metadata$median_genes >= 2000 &
  sample_metadata$mito_percent < 8

qc_result_vectorized

# 반복문 결과와 벡터화 결과를 비교하세요.
identical(qc_result_loop, qc_result_vectorized)

# ifelse()로 각 행의 레이블을 만드세요.
qc_labels_vectorized <- ifelse(
  qc_result_vectorized,
  "pass",
  "review"
)

qc_labels_vectorized

# TODO: cell_count_labels_loop와 같은 결과를 ifelse()로 만들어
# TODO: cell_count_labels_vectorized에 저장하고 비교하세요.


# 실습 8: 요약 함수를 사용하기 ---------------------------------------

# 반복문으로 합계를 계산하세요.
cell_count_sum_loop <- 0

for (cell_count in cell_counts) {
  cell_count_sum_loop <- cell_count_sum_loop + cell_count
}

cell_count_sum_loop

# 준비된 요약 함수로 같은 값을 계산하세요.
cell_count_sum_vectorized <- sum(cell_counts)
cell_count_sum_vectorized

# 두 결과가 같은지 확인하세요.
identical(cell_count_sum_loop, cell_count_sum_vectorized)

# 평균과 최댓값은 준비된 함수를 사용하세요.
mean(cell_counts)
max(cell_counts)

# TODO: median_genes의 합계, 평균, 최댓값을 준비된 함수로 계산하세요.


# 실습 9: 빈 벡터의 위치 번호 비교하기 ------------------------------

empty_values <- numeric(0)

# 두 방법의 결과가 어떻게 다른지 확인하세요.
1:length(empty_values)
seq_along(empty_values)

# 빈 벡터를 반복할 때 seq_along()을 사용하세요.
for (index in seq_along(empty_values)) {
  print(index)
}

# 반복할 값이 없으므로 아무것도 출력되지 않는 것이 정상입니다.


# 실습 10: 결과 정리하고 저장하기 ------------------------------------

# 최종 결과 열을 데이터 프레임에 추가하세요.
sample_metadata$qc_result <- qc_result_vectorized
sample_metadata$qc_label <- qc_labels_vectorized

# 필요한 열을 선택해 결과 데이터 프레임을 만드세요.
loop_comparison <- sample_metadata[, c(
  "sample_id",
  "cell_count",
  "cell_count_k_loop",
  "cell_count_k_vectorized",
  "qc_result_loop",
  "qc_result",
  "qc_label"
)]

loop_comparison

# 결과를 저장하고 다시 확인하세요.
dir.create("results", showWarnings = FALSE)
output_path <- "results/loop_comparison.csv"

write.csv(loop_comparison, output_path, row.names = FALSE)
file.exists(output_path)

saved_comparison <- read.csv(output_path)
saved_comparison


# 마무리 연습: 반복문을 벡터화 연산으로 바꾸기 -----------------------

doublet_rate <- sample_metadata$doublet_rate

# TODO: 각 값이 NA이면 "missing", 4 이하이면 "pass",
# TODO: 그 밖에는 "review"인 doublet_labels_loop를 반복문으로 만드세요.
# 힌트: 먼저 is.na(doublet_rate[index])를 확인합니다.

# TODO: 중첩된 ifelse()를 사용해 같은 결과를
# TODO: doublet_labels_vectorized에 저장하세요.

# TODO: 두 결과를 identical()로 비교하세요.
# TODO: 어떤 코드가 더 이해하기 쉬운지 이유와 함께 주석으로 적으세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 반복문 결과와 벡터화 결과가 같은지 확인하세요.
# TODO: 파일을 저장하세요.
