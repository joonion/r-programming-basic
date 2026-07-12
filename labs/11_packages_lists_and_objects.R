# 11차시 실습: 패키지, 리스트와 R 객체

# 이름:
# 날짜:


# 실습 준비: 샘플 메타데이터 불러오기 -------------------------------

input_path <- "data/sample_metadata.csv"
file.exists(input_path)

sample_metadata <- read.csv(input_path)
head(sample_metadata)

# 설치되지 않았다면 다음 줄을 콘솔에서 한 번 실행하세요.
# install.packages("ggplot2")
# install.packages("patchwork")
library(ggplot2)
library(patchwork)

dir.create("results", showWarnings = FALSE)


# 실습 1: 패키지 상태와 버전 확인하기 -------------------------------

# 기본 설치에 포함된 stats 패키지가 설치됐는지 확인하세요.
"stats" %in% rownames(installed.packages())
requireNamespace("stats", quietly = TRUE)

# 패키지 버전을 확인하세요.
packageVersion("stats")

# ::를 사용해 함수의 패키지를 명시하세요.
stats::median(sample_metadata$cell_count)
utils::head(sample_metadata, 3)

# 현재 R 실행 환경을 확인하세요.
sessionInfo()

# 외부 패키지 설치와 불러오기 예제입니다.
# 수업 스크립트 전체 실행에서는 실행하지 않습니다.
# install.packages("ggplot2")
# library(ggplot2)

# TODO: utils 패키지가 설치됐는지 requireNamespace()로 확인하세요.
# TODO: stats 패키지가 제공하는 sd()를 :: 표기로 호출하세요.


# 실습 1-1: 처음 보는 함수의 도움말 읽기 ----------------------------

# 도움말과 함수 인자 목록을 확인하세요.
?stats::median
args(stats::median)

# 작고 결과를 예상할 수 있는 입력으로 실행하세요.
stats::median(c(3, 1, 2))

# TODO: stats::quantile의 도움말과 인자 목록을 확인하세요.
# TODO: 도움말에서 입력, 기본값이 있는 인자, 반환값을 찾아보세요.


# 실습 2: 이름이 있는 리스트 만들기 -------------------------------

# 서로 다른 자료형의 샘플 정보를 리스트로 만드세요.
sample_result <- list(
  sample_id = "control_1",
  cell_count = 1240,
  passed_qc = TRUE,
  qc_metrics = c(median_genes = 2180, mito_percent = 4.2)
)

sample_result
names(sample_result)
length(sample_result)
str(sample_result)

# TODO: condition = "control" 원소를 리스트에 추가하세요.


# 실습 3: 리스트 원소 선택하기 ---------------------------------------

# $로 원소 내용을 선택하세요.
sample_result$sample_id
sample_result$cell_count

# [[ ]]로 위치와 이름을 사용해 원소 내용을 선택하세요.
sample_result[[1]]
sample_result[["cell_count"]]

# [ ]로 원소를 포함한 리스트를 선택하세요.
sample_result[1]
sample_result["cell_count"]

# 결과의 클래스를 비교하세요.
class(sample_result["cell_count"])
class(sample_result[["cell_count"]])

# 여러 원소를 리스트로 선택하세요.
sample_result[c("sample_id", "passed_qc")]

# TODO: qc_metrics를 $와 [[ ]]로 각각 선택하고 결과를 비교하세요.
# TODO: qc_metrics 안의 mito_percent 값을 이름으로 선택하세요.


# 실습 4: 리스트 원소 수정하고 추가하기 -----------------------------

# 기존 값을 수정하세요.
sample_result$cell_count <- 1300
sample_result$cell_count

# 새로운 원소를 추가하세요.
sample_result$doublet_rate <- 3.1
sample_result

# 임시 원소를 추가한 뒤 NULL로 제거하세요.
sample_result$temporary_note <- "remove me"
names(sample_result)

sample_result$temporary_note <- NULL
names(sample_result)

# TODO: passed_qc를 FALSE로 수정한 뒤 다시 TRUE로 되돌리세요.


# 실습 5: 중첩 리스트 만들고 탐색하기 -------------------------------

# 분석 설정을 중첩 리스트로 만드세요.
analysis_parameters <- list(
  project_name = "training_project",
  qc = list(
    min_cells = 1200,
    min_genes = 2000,
    max_mito = 8,
    max_doublet = 4
  ),
  output = list(
    directory = "results",
    save_plots = TRUE
  )
)

# 바깥 구조부터 확인하세요.
names(analysis_parameters)
str(analysis_parameters, max.level = 2)

# 한 단계씩 안쪽 값에 접근하세요.
analysis_parameters$project_name
analysis_parameters$qc
analysis_parameters$qc$min_cells
analysis_parameters[["output"]][["save_plots"]]

# TODO: max_mito 값을 7로 수정하세요.
# TODO: output 안의 directory 값을 선택하세요.


# 실습 6: 여러 종류의 결과를 하나의 리스트로 묶기 ------------------

# 교육용 유전자 발현 행렬을 만드세요.
expression_counts <- matrix(
  c(
    12, 15, 11, 30, 28, 32,
    4, 3, 5, 18, 16, 20,
    25, 22, 27, 8, 10, 7
  ),
  nrow = 3,
  byrow = TRUE,
  dimnames = list(
    c("MS4A1", "CD3D", "LYZ"),
    sample_metadata$sample_id
  )
)

expression_counts

# 조건별 평균 세포 수를 계산하세요.
condition_summary <- aggregate(
  cell_count ~ condition,
  data = sample_metadata,
  FUN = mean
)

# 여러 객체를 하나의 분석 결과 리스트로 묶으세요.
analysis_result <- list(
  counts = expression_counts,
  metadata = sample_metadata,
  summary = condition_summary,
  parameters = analysis_parameters
)

names(analysis_result)
str(analysis_result, max.level = 2)

# TODO: 분석 생성 날짜를 나타내는 created_on 원소를 추가하세요.
# 힌트: 현재 날짜와 무관한 고정 문자열을 사용해도 됩니다.


# 실습 7: 중첩된 분석 결과에서 값 꺼내기 ----------------------------

# 발현 행렬과 메타데이터를 선택하세요.
analysis_result$counts
head(analysis_result$metadata)

# 특정 유전자의 모든 샘플 값을 선택하세요.
analysis_result$counts["MS4A1", ]

# 특정 샘플의 메타데이터 행을 선택하세요.
analysis_result$metadata[
  analysis_result$metadata$sample_id == "control_1",
]

# 깊은 위치의 QC 설정값을 선택하세요.
analysis_result$parameters$qc$min_genes

# TODO: CD3D의 treated_1 값을 선택하세요.
# TODO: summary 데이터 프레임에서 treated 행을 선택하세요.


# 실습 8: 객체의 클래스, 구조, 속성 조사하기 -----------------------

# 여러 객체의 클래스를 비교하세요.
class(expression_counts)
class(sample_metadata)
class(analysis_result)

# 내부 저장 방식을 비교하세요.
typeof(expression_counts)
typeof(sample_metadata)
typeof(analysis_result)

# 구조와 속성을 확인하세요.
str(analysis_result, max.level = 2)
attributes(expression_counts)
attributes(sample_metadata)

# 객체가 차지하는 메모리 크기를 확인하세요.
object.size(analysis_result)
format(object.size(analysis_result), units = "auto")

# 데이터 프레임도 리스트인지 확인하세요.
is.list(sample_metadata)

# TODO: analysis_result의 각 원소를 class()로 확인하세요.


# 실습 9: 객체에 따라 함수 결과 비교하기 ---------------------------

# 같은 summary()를 서로 다른 클래스에 적용하세요.
summary(sample_metadata$cell_count)
summary(sample_metadata)

# summary에 사용할 수 있는 메서드 일부를 확인하세요.
head(methods("summary"))

# TODO: expression_counts와 condition_summary에 summary()를 적용하고
# TODO: 결과가 어떻게 다른지 주석으로 설명하세요.


# 실습 9-1: 문자열 패턴으로 이름 찾기 -------------------------------

gene_names <- c("MT-CO1", "ACTB", "MT-ND1", "GAPDH", "GENE-MT-1")

# MT-로 시작하는지 각 원소별 논리값으로 확인하세요.
grepl("^MT-", gene_names)

# MT-로 시작하는 이름만 반환하세요.
grep("^MT-", gene_names, value = TRUE)

# ^가 없을 때 결과가 어떻게 달라지는지 비교하세요.
grep("MT-", gene_names, value = TRUE)

# TODO: G로 시작하는 유전자 이름을 찾으세요.
# TODO: grepl()과 grep(..., value = TRUE)의 결과 차이를 설명하세요.


# 실습 10: 그래프를 R 객체로 다루기 --------------------------------

qc_plot <- ggplot(
  sample_metadata,
  aes(x = condition, y = cell_count, fill = condition)
) +
  geom_boxplot() +
  labs(
    title = "실험 조건별 세포 수",
    x = "실험 조건",
    y = "세포 수"
  ) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

relationship_plot <- ggplot(
  sample_metadata,
  aes(x = cell_count, y = median_genes, color = condition)
) +
  geom_point(size = 3) +
  labs(
    title = "세포 수와 검출 유전자 수의 관계",
    x = "세포 수",
    y = "검출 유전자 수 중앙값"
  ) +
  theme_minimal(base_size = 14)

combined_plot <- qc_plot | relationship_plot

class(qc_plot)
class(combined_plot)
combined_plot

ggsave(
  filename = "results/11_qc_plot_objects.png",
  plot = combined_plot,
  width = 10,
  height = 5,
  dpi = 150
)

file.exists("results/11_qc_plot_objects.png")

# TODO: qc_plot에 부제목을 추가해 새 객체로 저장하세요.
# TODO: 두 그래프를 위아래로 배치한 객체를 만드세요.


# 실습 11: 복합 객체를 RDS로 저장하고 복원하기 ---------------------

# 리스트 전체를 RDS 파일로 저장하세요.
rds_path <- "results/analysis_result.rds"

saveRDS(analysis_result, rds_path)
file.exists(rds_path)

# 저장한 객체를 새 변수로 다시 불러오세요.
restored_result <- readRDS(rds_path)

# 복원한 객체의 구조를 확인하세요.
class(restored_result)
names(restored_result)
str(restored_result, max.level = 2)

# 저장 전후가 완전히 같은지 확인하세요.
identical(analysis_result, restored_result)

# 복원된 객체에서 값을 다시 선택하세요.
restored_result$parameters$project_name
restored_result$counts["LYZ", "treated_2"]


# 마무리 연습: 작은 전사체 분석 객체 탐색하기 ----------------------

# TODO: analysis_result의 최상위 원소 이름을 확인하세요.
# TODO: 각 최상위 원소의 클래스를 확인하세요.
# TODO: counts 행렬의 행 이름과 열 이름을 확인하세요.
# TODO: metadata의 행 수가 counts의 열 수와 같은지 확인하세요.
# TODO: QC 설정값 네 개를 qc_settings에 리스트로 저장하세요.
# TODO: qc_settings를 results/qc_settings.rds로 저장하고 복원하세요.
# TODO: 저장 전후 객체가 같은지 identical()로 확인하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 리스트 접근 결과가 리스트인지 원소 내용인지 확인하세요.
# TODO: 처음 보는 함수에서 입력, 인자, 기본값, 반환값을 확인하세요.
# TODO: "^MT-" 패턴에서 ^가 뜻하는 바를 설명하세요.
# TODO: @가 S4 객체의 슬롯을 읽는 연산자임을 설명하세요.
# TODO: RDS 파일을 복원한 뒤 구조와 값을 확인하세요.
# TODO: 파일을 저장하세요.
