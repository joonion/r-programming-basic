# 2차시 실습: 변수와 기본 자료형

# 이름:
# 날짜:


# 실습 1: 세 가지 기본 자료형 만들기 ---------------------------------

# 가상의 전사체 샘플 정보를 변수에 저장하세요.
sample_name <- "control_1"
cell_count <- 1250
passed_qc <- TRUE

# 변수 이름을 실행하여 현재 값을 확인하세요.
sample_name
cell_count
passed_qc

# 각 변수의 자료형을 확인하세요.
class(sample_name)
class(cell_count)
class(passed_qc)

# R의 내부 저장 방식도 확인하고 class()의 결과와 비교하세요.
typeof(sample_name)
typeof(cell_count)
typeof(passed_qc)


# 실습 2: 변수 값 변경하고 계산하기 ----------------------------------

# 필터링 전후의 세포 수를 저장하세요.
cell_count <- 1250
filtered_cell_count <- 1100

# 제거된 세포 수를 계산하세요.
removed_cell_count <- cell_count - filtered_cell_count
removed_cell_count

# cell_count를 1400으로 변경한 다음 계산을 다시 실행하세요.
cell_count <- 1400
removed_cell_count <- cell_count - filtered_cell_count
removed_cell_count

# TODO: filtered_cell_count를 1200으로 변경하세요.
# TODO: removed_cell_count를 다시 계산하고 결과를 확인하세요.


# 실습 3: 결측값 확인하기 --------------------------------------------

# 아직 계산되지 않은 이중체 비율을 NA로 저장하세요.
doublet_rate <- NA

doublet_rate
is.na(doublet_rate)

# 결측값이 아닌 변수와 결과를 비교하세요.
sample_name <- "control_1"
is.na(sample_name)

# NA가 포함된 계산의 결과를 확인하세요.
adjusted_doublet_rate <- doublet_rate + 1
adjusted_doublet_rate

# TODO: missing_value라는 변수에 NA를 저장하세요.
# TODO: is.na()를 사용해 결측값인지 확인하세요.


# 실습 4: 자료형 변환하기 --------------------------------------------

# 숫자처럼 보이지만 따옴표로 감싼 값은 문자형입니다.
cell_count_text <- "1250"
class(cell_count_text)

# 문자형 값을 숫자형으로 변환하세요.
cell_count_number <- as.numeric(cell_count_text)
cell_count_number
class(cell_count_number)

# 숫자형 값을 문자형으로 변환하세요.
cell_count_label <- as.character(cell_count_number)
cell_count_label
class(cell_count_label)

# 문자형 값을 논리형으로 변환하세요.
qc_text <- "TRUE"
qc_result <- as.logical(qc_text)
qc_result
class(qc_result)

# TODO: 문자형 "980"을 숫자형으로 변환하여
# TODO: treated_cell_count에 저장하세요.


# 실습 5: 자료형 관련 오류 수정하기 ----------------------------------

# 아래의 잘못된 코드는 전체 실행을 방해하지 않도록 주석 처리했습니다.
# 각 코드가 왜 오류를 만드는지 설명하고, 바로 아래의 수정 코드를
# 실행하여 결과를 확인하세요.

# 오류 1: 문자형 값에 따옴표가 없습니다.
# condition <- treated
condition <- "treated"
condition

# 오류 2: 변수 이름의 대소문자가 다릅니다.
# Cell_count + 100
cell_count <- 1250
cell_count + 100

# 오류 3: 문자형 값으로 산술 계산을 시도합니다.
# cell_count_text + 100
cell_count_number <- as.numeric(cell_count_text)
cell_count_number + 100

# 선택 실습: 오류 코드를 한 줄씩 직접 실행해 오류 메시지를 확인하세요.
# 확인한 뒤에는 수정 코드가 어떻게 문제를 해결하는지 비교하세요.


# 마무리 연습: 샘플 정보 표현하기 ------------------------------------

# 다음 정보를 알맞은 자료형의 변수로 저장하세요.
# - 샘플 이름: treated_1
# - 세포 수: 1580
# - QC 통과 여부: 참
# - 미토콘드리아 유전자 비율: 아직 측정하지 않음

# TODO: sample_name을 작성하세요.
# TODO: cell_count를 작성하세요.
# TODO: passed_qc를 작성하세요.
# TODO: mito_percent를 작성하세요.

# 작성한 네 변수의 값과 자료형을 확인하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 파일을 저장하세요.
