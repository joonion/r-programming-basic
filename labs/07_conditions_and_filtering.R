# 7차시 실습: 조건식과 데이터 필터링

# 이름:
# 날짜:


# 실습 준비: 샘플 메타데이터 불러오기 -------------------------------

input_path <- "data/sample_metadata.csv"
file.exists(input_path)

sample_metadata <- read.csv(input_path)
head(sample_metadata)
str(sample_metadata)

# 이 실습의 수치는 R 조건식 연습을 위한 예시입니다.
# 실제 전사체 QC 기준은 데이터 분포와 실험 맥락을 검토해 정합니다.


# 실습 1: 비교 연산자로 조건 만들기 ----------------------------------

# 세포 수가 1200 이상인지 확인하세요.
enough_cells <- sample_metadata$cell_count >= 1200
enough_cells

# 미토콘드리아 유전자 비율이 8 미만인지 확인하세요.
low_mito <- sample_metadata$mito_percent < 8
low_mito

# treated 조건인지 확인하세요.
is_treated <- sample_metadata$condition == "treated"
is_treated

# batch_2가 아닌지 확인하세요.
not_batch_2 <- sample_metadata$batch != "batch_2"
not_batch_2

# TODO: median_genes가 2000 이상인지 나타내는
# TODO: enough_genes 조건을 만드세요.


# 실습 2: 단일 조건으로 행 선택하기 ----------------------------------

# 세포 수가 1200 이상인 샘플을 선택하세요.
sample_metadata[enough_cells, ]

# treated 조건의 샘플을 선택하세요.
treated_metadata <- sample_metadata[is_treated, ]
treated_metadata

# 조건을 만족하는 샘플 수를 계산하세요.
sum(enough_cells)
sum(is_treated)

# TODO: mito_percent가 8 이상인 샘플을 선택하세요.
# TODO: 선택된 샘플이 몇 개인지 계산하세요.


# 실습 3: 여러 범주 중 하나 선택하기 ---------------------------------

# batch_1 또는 batch_3에 속하는지 확인하세요.
selected_batches <- c("batch_1", "batch_3")
in_selected_batch <- sample_metadata$batch %in% selected_batches
in_selected_batch

# 조건에 맞는 행을 선택하세요.
sample_metadata[in_selected_batch, ]

# TODO: sample_id가 control_1 또는 treated_1인 행을
# TODO: %in%을 사용하여 선택하세요.


# 실습 4: 논리 연산자로 조건 결합하기 --------------------------------

# 세포 수와 미토콘드리아 비율 기준을 모두 만족하는지 확인하세요.
cell_and_mito_condition <- enough_cells & low_mito
cell_and_mito_condition
sample_metadata[cell_and_mito_condition, ]

# 세포 수가 적거나 미토콘드리아 비율이 높은지 확인하세요.
few_cells <- sample_metadata$cell_count < 1200
high_mito <- sample_metadata$mito_percent >= 8

review_condition <- few_cells | high_mito
review_condition
sample_metadata[review_condition, ]

# QC를 통과하지 못한 샘플을 선택하세요.
failed_qc <- !sample_metadata$passed_qc
sample_metadata[failed_qc, ]

# TODO: control 조건이면서 batch_1인 샘플을 선택하세요.


# 실습 5: 여러 QC 조건으로 필터링하기 --------------------------------

# 각 QC 조건을 별도로 만드세요.
enough_cells <- sample_metadata$cell_count >= 1200
enough_genes <- sample_metadata$median_genes >= 2000
low_mito <- sample_metadata$mito_percent < 8

# 세 조건을 모두 결합하세요.
qc_condition <- enough_cells & enough_genes & low_mito
qc_condition

# 통과한 샘플과 검토할 샘플을 각각 저장하세요.
qc_passed_metadata <- sample_metadata[qc_condition, ]
qc_review_metadata <- sample_metadata[!qc_condition, ]

qc_passed_metadata
qc_review_metadata

# 행 수의 합이 원본 행 수와 같은지 확인하세요.
nrow(qc_passed_metadata) + nrow(qc_review_metadata)
nrow(sample_metadata)

# TODO: QC를 통과한 샘플 수와 비율을 계산하세요.
# 힌트: 비율은 sum(qc_condition) / length(qc_condition)입니다.


# 실습 6: 결측값이 있는 조건 처리하기 -------------------------------

# doublet_rate가 4 이하인지 비교하세요.
low_doublet_rate <- sample_metadata$doublet_rate <= 4
low_doublet_rate

# 결측값이 아닌 위치를 확인하세요.
known_doublet_rate <- !is.na(sample_metadata$doublet_rate)
known_doublet_rate

# 측정값이 있으면서 4 이하인 샘플만 선택하세요.
doublet_condition <- known_doublet_rate & low_doublet_rate
sample_metadata[doublet_condition, ]

# 결측값이 있는 샘플을 별도로 확인하세요.
missing_doublet_rate <- is.na(sample_metadata$doublet_rate)
sample_metadata[missing_doublet_rate, ]

# TODO: doublet_rate가 측정됐고 3.5 미만인 샘플을 선택하세요.


# 실습 7: any(), all(), which() 사용하기 ------------------------------

# 하나라도 높은 mito_percent 값을 가지는지 확인하세요.
any(sample_metadata$mito_percent >= 8)

# 모든 샘플의 cell_count가 900 이상인지 확인하세요.
all(sample_metadata$cell_count >= 900)

# QC를 통과한 행의 위치 번호를 확인하세요.
which(sample_metadata$passed_qc)

# TODO: 모든 sample_id가 중복 없이 고유한지 확인하세요.
# 힌트: duplicated(), any(), !를 사용합니다.


# 실습 8: if와 if ... else 사용하기 ----------------------------------

# 단일 샘플의 값에 따라 메시지를 만드세요.
cell_count <- 1240

if (cell_count >= 1200) {
  cell_message <- "세포 수 기준을 만족합니다."
} else {
  cell_message <- "세포 수 기준을 만족하지 않습니다."
}

cell_message

# 데이터 전체에 검토할 샘플이 있는지에 따라 메시지를 만드세요.
has_review_sample <- any(!qc_condition)

if (has_review_sample) {
  qc_message <- "검토가 필요한 샘플이 있습니다."
} else {
  qc_message <- "모든 샘플이 기준을 만족합니다."
}

qc_message

# TODO: 중복 sample_id가 있으면 "중복 있음", 없으면 "중복 없음"을
# TODO: duplicate_message에 저장하는 if ... else 문을 작성하세요.


# 실습 9: ifelse()로 열 만들기 ---------------------------------------

# 각 샘플의 조건에 따라 QC 레이블을 만드세요.
sample_metadata$qc_label <- ifelse(
  qc_condition,
  "pass",
  "review"
)

sample_metadata[, c("sample_id", "qc_label")]

# cell_count에 따라 크기 범주를 만드세요.
sample_metadata$cell_count_group <- ifelse(
  sample_metadata$cell_count >= 1200,
  "high",
  "low"
)

sample_metadata[, c("sample_id", "cell_count", "cell_count_group")]

# TODO: condition이 "treated"이면 "T", 아니면 "C"인
# TODO: condition_code 열을 만드세요.


# 실습 10: 필터링 결과 저장하기 --------------------------------------

dir.create("results", showWarnings = FALSE)

output_path <- "results/qc_passed_metadata.csv"

write.csv(
  qc_passed_metadata,
  output_path,
  row.names = FALSE
)

file.exists(output_path)

# 저장 결과를 다시 불러와 확인하세요.
saved_qc_metadata <- read.csv(output_path)
saved_qc_metadata
str(saved_qc_metadata)

# TODO: qc_review_metadata를
# TODO: results/qc_review_metadata.csv에 저장하고 다시 확인하세요.


# 마무리 연습: 분석 대상 샘플 선택하기 -------------------------------

# 다음 네 조건을 모두 만족하는 샘플을 선택하세요.
# - condition이 treated
# - cell_count가 1200 이상
# - mito_percent가 8 미만
# - doublet_rate가 결측값이 아니며 4 이하

# TODO: 각 조건을 따로 만든 뒤 analysis_condition으로 결합하세요.
# TODO: 조건 결과를 출력하고 TRUE의 개수를 계산하세요.
# TODO: 선택한 행을 analysis_samples에 저장하세요.
# TODO: analysis_samples의 행 수와 내용을 확인하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 결과 파일이 생성됐는지 확인하세요.
# TODO: 파일을 저장하세요.
