# 3차시 실습: 벡터와 인덱싱

# 이름:
# 날짜:


# 실습 1: 벡터 만들고 확인하기 ---------------------------------------

# 세 샘플의 이름, 세포 수, QC 통과 여부를 벡터로 만드세요.
sample_names <- c("control_1", "control_2", "treated_1")
cell_counts <- c(1200, 1350, 980)
passed_qc <- c(TRUE, TRUE, FALSE)

# 각 벡터의 값, 자료형, 길이를 확인하세요.
sample_names
class(sample_names)
length(sample_names)

cell_counts
class(cell_counts)
length(cell_counts)

passed_qc
class(passed_qc)
length(passed_qc)

# TODO: 세 샘플의 조건을 담은 conditions 벡터를 만드세요.
# 값은 순서대로 "control", "control", "treated"입니다.


# 실습 2: 규칙적인 벡터 만들기 --------------------------------------

# 1부터 5까지의 샘플 번호를 만드세요.
sample_numbers <- 1:5
sample_numbers

# 2부터 10까지 2씩 증가하는 숫자를 만드세요.
even_numbers <- seq(from = 2, to = 10, by = 2)
even_numbers

# "control"을 세 번 반복하세요.
control_labels <- rep("control", times = 3)
control_labels

# TODO: TRUE를 네 번 반복한 qc_flags 벡터를 만드세요.


# 실습 3: 위치로 원소 선택하기 ---------------------------------------

cell_counts <- c(1200, 1350, 980, 1420)

# 첫 번째 원소를 선택하세요.
cell_counts[1]

# 첫 번째와 세 번째 원소를 선택하세요.
cell_counts[c(1, 3)]

# 두 번째부터 네 번째 원소를 선택하세요.
cell_counts[2:4]

# 첫 번째 원소를 제외하세요.
cell_counts[-1]

# TODO: 두 번째와 네 번째 원소를 선택하세요.
# TODO: 두 번째 원소를 제외한 나머지를 선택하세요.


# 실습 4: 이름으로 원소 선택하기 -------------------------------------

# 각 세포 수에 샘플 이름을 붙이세요.
named_cell_counts <- c(
  control_1 = 1200,
  control_2 = 1350,
  treated_1 = 980,
  treated_2 = 1420
)

named_cell_counts
names(named_cell_counts)

# 이름으로 한 원소와 여러 원소를 선택하세요.
named_cell_counts["control_2"]
named_cell_counts[c("control_1", "treated_1")]

# TODO: treated_2의 세포 수를 이름으로 선택하세요.


# 실습 5: 조건으로 원소 선택하기 -------------------------------------

cell_counts <- c(1200, 1350, 980, 1420)
conditions <- c("control", "control", "treated", "treated")

# 세포 수가 1200 이상인지 비교하세요.
enough_cells <- cell_counts >= 1200
enough_cells

# 조건을 만족하는 세포 수만 선택하세요.
cell_counts[enough_cells]

# treated 조건에 해당하는 세포 수만 선택하세요.
treated_samples <- conditions == "treated"
treated_samples
cell_counts[treated_samples]

# 비교와 선택을 한 줄로 작성할 수도 있습니다.
cell_counts[cell_counts >= 1200]
cell_counts[conditions == "treated"]

# TODO: 세포 수가 1000 미만인 원소만 선택하세요.


# 실습 6: 벡터 연산하기 ----------------------------------------------

raw_counts <- c(1200, 1350, 980, 1420)
filtered_counts <- c(1100, 1250, 900, 1300)

# 모든 원소에 같은 계산을 적용하세요.
raw_counts + 100
raw_counts / 1000

# 같은 위치의 원소끼리 계산하세요.
removed_counts <- raw_counts - filtered_counts
removed_counts

# TODO: 각 샘플에서 남은 세포의 비율을 계산하세요.
# 힌트: filtered_counts를 raw_counts로 나눕니다.


# 실습 7: 벡터 요약하기 ----------------------------------------------

# 필터링 후 세포 수를 여러 방법으로 요약하세요.
sum(filtered_counts)
mean(filtered_counts)
median(filtered_counts)
min(filtered_counts)
max(filtered_counts)
summary(filtered_counts)

# 제거된 세포 수가 가장 큰 값도 확인하세요.
max(removed_counts)

# TODO: raw_counts의 평균과 최솟값을 계산하세요.


# 실습 8: 결측값 확인하고 요약하기 -----------------------------------

# 두 번째 샘플의 유전자 수가 측정되지 않은 상황입니다.
gene_counts <- c(18000, NA, 19500, 17200)

# 결측값의 위치를 확인하세요.
is.na(gene_counts)

# 결측값의 개수를 계산하세요.
missing_count <- sum(is.na(gene_counts))
missing_count

# NA가 포함된 평균 결과를 확인하세요.
mean(gene_counts)

# NA를 제외하고 평균을 계산하세요.
mean(gene_counts, na.rm = TRUE)

# TODO: NA를 제외한 gene_counts의 최솟값과 최댓값을 계산하세요.


# 마무리 연습: 네 샘플의 QC 결과 살펴보기 ----------------------------

sample_names <- c("control_1", "control_2", "treated_1", "treated_2")
cell_counts <- c(1200, 1350, 980, 1420)
passed_qc <- c(TRUE, TRUE, FALSE, TRUE)

# TODO: 세 벡터의 길이가 같은지 각각 length()로 확인하세요.
# TODO: QC를 통과한 샘플 이름만 선택하세요.
# TODO: QC를 통과한 샘플의 세포 수만 선택하세요.
# TODO: QC를 통과한 샘플의 평균 세포 수를 계산하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 파일을 저장하세요.
