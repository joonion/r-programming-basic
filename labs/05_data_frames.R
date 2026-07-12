# 5차시 실습: 데이터 프레임 다루기

# 이름:
# 날짜:


# 실습 1: 데이터 프레임 만들기 ---------------------------------------

# 네 샘플의 정보를 하나의 데이터 프레임으로 만드세요.
sample_info <- data.frame(
  sample_name = c("control_1", "control_2", "treated_1", "treated_2"),
  condition = c("control", "control", "treated", "treated"),
  cell_count = c(1200, 1350, 980, 1420),
  passed_qc = c(TRUE, TRUE, FALSE, TRUE)
)

# 전체 표를 출력하세요.
sample_info

# 앞부분과 뒷부분을 확인하세요.
head(sample_info)
tail(sample_info)


# 실습 2: 데이터 프레임의 구조 확인하기 ------------------------------

# 행 수와 열 수를 함께 확인하세요.
dim(sample_info)

# 행 수와 열 수를 각각 확인하세요.
nrow(sample_info)
ncol(sample_info)

# 열 이름과 각 열의 자료형을 확인하세요.
names(sample_info)
str(sample_info)

# 열별 요약 정보를 확인하세요.
summary(sample_info)

# TODO: colnames()로 열 이름을 다시 확인하세요.
# TODO: head()로 처음 두 행만 확인하세요.


# 실습 3: 열 선택하기 -------------------------------------------------

# $로 cell_count 열을 선택하세요.
sample_info$cell_count

# [[ ]]로 같은 열을 선택하고 결과를 비교하세요.
sample_info[["cell_count"]]

# 열 이름을 변수에 저장하여 선택하세요.
column_name <- "condition"
sample_info[[column_name]]

# 여러 열을 데이터 프레임으로 선택하세요.
sample_info[, c("sample_name", "cell_count")]

# 한 열을 데이터 프레임 형태로 유지하세요.
sample_info[, "cell_count", drop = FALSE]

# TODO: $를 사용해 passed_qc 열을 선택하세요.
# TODO: sample_name과 passed_qc 열을 함께 선택하세요.


# 실습 4: 행과 셀 선택하기 -------------------------------------------

# 첫 번째 행의 모든 열을 선택하세요.
sample_info[1, ]

# 첫 번째와 세 번째 행을 선택하세요.
sample_info[c(1, 3), ]

# 첫 번째 행, 두 번째 열의 값을 선택하세요.
sample_info[1, 2]

# 행과 열을 모두 이름 또는 위치로 지정할 수 있습니다.
sample_info[2, "cell_count"]

# TODO: 두 번째부터 네 번째 행을 선택하세요.
# TODO: 세 번째 행의 sample_name을 선택하세요.


# 실습 5: 조건으로 행 선택하기 ---------------------------------------

# QC 통과 여부를 논리형 벡터로 확인하세요.
sample_info$passed_qc

# QC를 통과한 행만 선택하세요.
qc_passed_samples <- sample_info[sample_info$passed_qc, ]
qc_passed_samples

# 세포 수가 1200 이상인 행을 선택하세요.
enough_cells <- sample_info$cell_count >= 1200
enough_cells
sample_info[enough_cells, ]

# TODO: condition이 "treated"인 행을 선택하세요.
# 힌트: sample_info$condition == "treated"


# 실습 6: 새로운 열 추가하기 -----------------------------------------

# 세포 수의 단위를 천 개로 바꾼 열을 추가하세요.
sample_info$cell_count_k <- sample_info$cell_count / 1000
sample_info

# 샘플 이름과 처리 조건을 조합한 새 열을 추가합니다.
# paste()의 자세한 사용법은 이후 수업에서 다시 다룹니다.
sample_info$sample_label <- paste(
  sample_info$sample_name,
  sample_info$condition,
  sep = "_"
)
sample_info

# TODO: cell_count가 1000 이상인지 나타내는
# TODO: enough_cells 열을 추가하세요.


# 실습 7: 기존 값 수정하기 -------------------------------------------

# 수정 전에 대상 값을 확인하세요.
sample_info[3, "cell_count"]

# 세 번째 샘플의 세포 수를 1050으로 수정하세요.
sample_info[3, "cell_count"] <- 1050
sample_info[3, "cell_count"]

# condition 열을 팩터로 변환하세요.
sample_info$condition <- factor(sample_info$condition)
str(sample_info)

# TODO: 네 번째 샘플의 passed_qc 값을 FALSE로 수정하세요.
# TODO: 수정한 행을 출력하여 결과를 확인하세요.


# 실습 8: 결측값 확인하기 --------------------------------------------

# 일부 값이 측정되지 않은 이중체 비율 열을 추가하세요.
sample_info$doublet_rate <- c(3.2, NA, 4.1, 2.8)
sample_info

# 각 값이 결측값인지 확인하세요.
is.na(sample_info$doublet_rate)

# doublet_rate 열의 결측값 개수를 계산하세요.
missing_doublet_rates <- sum(is.na(sample_info$doublet_rate))
missing_doublet_rates

# 모든 열에 값이 있는 행을 확인하세요.
complete_rows <- complete.cases(sample_info)
complete_rows
sample_info[complete_rows, ]

# TODO: doublet_rate가 NA인 샘플의 이름을 선택하세요.
# 힌트: is.na(sample_info$doublet_rate)를 행 선택에 사용합니다.


# 마무리 연습: 샘플 정보표 완성하기 ----------------------------------

# TODO: sample_info의 행 수, 열 수, 열 이름을 확인하세요.
# TODO: sample_name, condition, passed_qc 열만 선택하세요.
# TODO: QC를 통과한 샘플만 qc_result에 저장하세요.
# TODO: qc_result에 cell_count_k 열을 추가하세요.
# TODO: qc_result의 구조와 전체 내용을 확인하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 파일을 저장하세요.
