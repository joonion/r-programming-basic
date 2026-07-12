# 6차시 실습: 데이터 불러오기와 저장하기

# 이름:
# 날짜:


# 실습 준비: 프로젝트와 파일 경로 확인하기 ---------------------------

# 이 스크립트는 프로젝트 루트를 작업 폴더로 두고 실행합니다.
getwd()

# 불러올 파일의 상대 경로를 저장하세요.
input_path <- "data/sample_metadata.csv"

# 파일이 실제로 존재하는지 확인하세요.
file.exists(input_path)


# 실습 1: CSV 파일 불러오기 ------------------------------------------

# CSV 파일을 데이터 프레임으로 불러오세요.
sample_metadata <- read.csv(input_path)

# 처음과 마지막 행을 확인하세요.
head(sample_metadata)
tail(sample_metadata)

# TODO: head()를 사용해 처음 세 행만 확인하세요.


# 실습 2: 데이터의 크기와 구조 확인하기 ------------------------------

# 행 수와 열 수를 확인하세요.
dim(sample_metadata)
nrow(sample_metadata)
ncol(sample_metadata)

# 열 이름과 자료형을 확인하세요.
names(sample_metadata)
str(sample_metadata)

# 열별 요약 정보를 확인하세요.
summary(sample_metadata)

# TODO: 샘플이 모두 몇 개인지 nrow() 결과로 확인하세요.
# TODO: cell_count 열의 자료형을 class()로 확인하세요.


# 실습 3: 결측값 확인하기 --------------------------------------------

# 데이터 전체에 결측값이 하나라도 있는지 확인하세요.
anyNA(sample_metadata)

# 열별 결측값 개수를 확인하세요.
missing_by_column <- colSums(is.na(sample_metadata))
missing_by_column

# 결측값이 하나라도 있는 행을 선택하세요.
incomplete_rows <- !complete.cases(sample_metadata)
sample_metadata[incomplete_rows, ]

# TODO: doublet_rate 열의 결측값 개수를 sum()과 is.na()로 계산하세요.


# 실습 4: 중복값과 범주 확인하기 -------------------------------------

# sample_id의 각 값이 중복인지 확인하세요.
duplicated(sample_metadata$sample_id)

# 중복 sample_id가 하나라도 있는지 확인하세요.
any(duplicated(sample_metadata$sample_id))

# condition과 batch의 고유한 값을 확인하세요.
unique(sample_metadata$condition)
unique(sample_metadata$batch)

# TODO: passed_qc 열에 어떤 값이 있는지 unique()로 확인하세요.


# 실습 5: 숫자형 값 점검하기 -----------------------------------------

# cell_count의 범위와 평균을 확인하세요.
min(sample_metadata$cell_count)
max(sample_metadata$cell_count)
mean(sample_metadata$cell_count)

# doublet_rate에는 NA가 있으므로 이를 제외하고 평균을 계산하세요.
mean(sample_metadata$doublet_rate, na.rm = TRUE)

# TODO: median_genes의 최솟값, 최댓값, 평균을 계산하세요.
# TODO: mito_percent의 요약 결과를 summary()로 확인하세요.


# 실습 6: 저장할 결과 열 추가하기 ------------------------------------

# 세포 수를 천 개 단위로 표현한 열을 추가하세요.
sample_metadata$cell_count_k <-
  sample_metadata$cell_count / 1000

# 새 열이 추가됐는지 확인하세요.
head(sample_metadata)
names(sample_metadata)

# TODO: median_genes가 2000 이상인지 나타내는
# TODO: enough_genes 열을 추가하세요.


# 실습 7: 결과 파일 저장하기 -----------------------------------------

# 결과 폴더가 있는지 확인하고, 없으면 만드세요.
dir.exists("results")
dir.create("results", showWarnings = FALSE)
dir.exists("results")

# 저장할 파일의 상대 경로를 지정하세요.
output_path <- "results/sample_metadata_checked.csv"

# 행 번호를 제외하고 CSV 파일로 저장하세요.
write.csv(
  sample_metadata,
  output_path,
  row.names = FALSE
)

# 결과 파일이 생성됐는지 확인하세요.
file.exists(output_path)


# 실습 8: 저장 결과 다시 불러오기 ------------------------------------

# 저장한 파일을 새 변수로 다시 불러오세요.
saved_metadata <- read.csv(output_path)

# 저장 전후의 크기와 열 이름을 비교하세요.
dim(sample_metadata)
dim(saved_metadata)

names(sample_metadata)
names(saved_metadata)

# 저장된 데이터의 처음 몇 행과 구조를 확인하세요.
head(saved_metadata)
str(saved_metadata)

# TODO: saved_metadata의 행 수가 sample_metadata와 같은지
# TODO: == 연산자로 비교하세요.


# 마무리 연습: 새로운 결과 파일 만들기 -------------------------------

# TODO: sample_id, condition, passed_qc 열만 선택하여
# TODO: qc_overview 데이터 프레임에 저장하세요.
# TODO: qc_overview를 results/qc_overview.csv에 저장하세요.
# TODO: 저장한 파일이 존재하는지 file.exists()로 확인하세요.
# TODO: 저장한 파일을 다시 불러와 구조를 확인하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: results 폴더에 결과 파일이 생성됐는지 확인하세요.
# TODO: 파일을 저장하세요.
