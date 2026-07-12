# 12차시 실습: 미니 프로젝트 — 전사체 형태의 데이터 분석

# 이름:
# 날짜:

# 이 프로젝트의 데이터와 QC 수치는 교육용으로 만든 예시입니다.
# 실제 전사체 분석이나 차등 발현 분석 결과로 해석하지 않습니다.


# 1단계: 입력 파일 확인하고 불러오기 -------------------------------

metadata_path <- "data/sample_metadata.csv"
expression_path <- "data/gene_expression.csv"

# 두 입력 파일이 존재하는지 확인하세요.
file.exists(metadata_path)
file.exists(expression_path)

# CSV 파일을 불러오세요.
sample_metadata <- read.csv(metadata_path)

gene_expression <- read.csv(
  expression_path,
  check.names = FALSE
)

# 처음 몇 행을 확인하세요.
head(sample_metadata)
head(gene_expression)


# 2단계: 데이터 구조와 품질 점검하기 -------------------------------

# 행 수, 열 수, 열 이름, 자료형을 확인하세요.
dim(sample_metadata)
dim(gene_expression)

names(sample_metadata)
names(gene_expression)

str(sample_metadata)
str(gene_expression)

# 열별 결측값 개수를 확인하세요.
metadata_missing <- colSums(is.na(sample_metadata))
expression_missing <- colSums(is.na(gene_expression))

metadata_missing
expression_missing

# 샘플 ID와 유전자 ID의 중복 여부를 확인하세요.
duplicated_sample_ids <- any(duplicated(sample_metadata$sample_id))
duplicated_gene_ids <- any(duplicated(gene_expression$gene_id))

duplicated_sample_ids
duplicated_gene_ids

# 숫자형 값의 범위를 확인하세요.
summary(sample_metadata)
summary(gene_expression[, -1])

# 기본 품질 조건을 검증하세요.
stopifnot(!duplicated_sample_ids)
stopifnot(!duplicated_gene_ids)
stopifnot(!anyNA(gene_expression))

# TODO: sample_id와 gene_id에 결측값이 없는지 확인하세요.


# 3단계: 두 파일의 샘플 이름과 순서 검증하기 -----------------------

# 메타데이터의 sample_id와 발현표의 샘플 열 이름을 추출하세요.
metadata_sample_ids <- sample_metadata$sample_id
expression_sample_ids <- names(gene_expression)[-1]

metadata_sample_ids
expression_sample_ids

# 이름과 순서가 모두 같은지 확인하세요.
samples_aligned <- identical(
  metadata_sample_ids,
  expression_sample_ids
)

samples_aligned
stopifnot(samples_aligned)

# TODO: 두 샘플 ID 벡터의 길이도 같은지 확인하세요.


# 4단계: QC 조건 만들고 샘플 선택하기 -------------------------------

# 분석에 사용할 교육용 QC 기준을 리스트로 기록하세요.
qc_parameters <- list(
  min_cells = 1200,
  min_genes = 2000,
  max_mito = 8,
  max_doublet = 4
)

qc_parameters

# 각 QC 조건을 별도로 만드세요.
passed_initial_qc <- sample_metadata$passed_qc

enough_cells <-
  sample_metadata$cell_count >= qc_parameters$min_cells

enough_genes <-
  sample_metadata$median_genes >= qc_parameters$min_genes

low_mito <-
  sample_metadata$mito_percent < qc_parameters$max_mito

known_doublet_rate <-
  !is.na(sample_metadata$doublet_rate)

low_doublet_rate <-
  sample_metadata$doublet_rate <= qc_parameters$max_doublet

# 모든 QC 조건을 결합하세요.
qc_condition <-
  passed_initial_qc &
  enough_cells &
  enough_genes &
  low_mito &
  known_doublet_rate &
  low_doublet_rate

qc_condition

# QC 결과와 레이블을 메타데이터에 추가하세요.
sample_metadata$qc_result <- qc_condition
sample_metadata$qc_label <- ifelse(
  qc_condition,
  "pass",
  "review"
)

sample_metadata[, c(
  "sample_id",
  "condition",
  "qc_result",
  "qc_label"
)]

# QC 통과 메타데이터와 샘플 ID를 선택하세요.
analysis_metadata <- sample_metadata[qc_condition, ]
analysis_sample_ids <- analysis_metadata$sample_id

analysis_metadata
analysis_sample_ids

# 조건별 통과 샘플 수를 확인하세요.
analysis_condition_counts <- table(
  analysis_metadata$condition
)
analysis_condition_counts

# 두 조건 모두 분석 샘플을 가지는지 확인하세요.
stopifnot(all(c("control", "treated") %in%
  analysis_metadata$condition))

# TODO: 전체 샘플 중 QC 통과 샘플의 비율을 계산하세요.


# 5단계: 발현표에서 QC 통과 샘플 선택하기 ---------------------------

# gene_id와 분석 샘플 열만 선택하세요.
analysis_expression <- gene_expression[, c(
  "gene_id",
  analysis_sample_ids
)]

analysis_expression

# 필터링 후에도 이름과 순서가 같은지 확인하세요.
filtered_samples_aligned <- identical(
  analysis_metadata$sample_id,
  names(analysis_expression)[-1]
)

filtered_samples_aligned
stopifnot(filtered_samples_aligned)

# TODO: analysis_expression의 유전자 수와 샘플 수를 계산하세요.


# 6단계: 조건별 평균 발현량 계산하기 -------------------------------

# 각 조건의 분석 샘플 ID를 선택하세요.
control_ids <- analysis_metadata$sample_id[
  analysis_metadata$condition == "control"
]

treated_ids <- analysis_metadata$sample_id[
  analysis_metadata$condition == "treated"
]

control_ids
treated_ids

# 조건별 발현 데이터 프레임을 만드세요.
control_expression <- analysis_expression[
  , control_ids, drop = FALSE
]

treated_expression <- analysis_expression[
  , treated_ids, drop = FALSE
]

# 유전자별 조건 평균을 계산하세요.
control_mean <- rowMeans(control_expression)
treated_mean <- rowMeans(treated_expression)

# 유전자별 요약표를 만드세요.
gene_summary <- data.frame(
  gene_id = analysis_expression$gene_id,
  control_mean = control_mean,
  treated_mean = treated_mean
)

# treated와 control의 평균 차이를 계산하세요.
gene_summary$difference <-
  gene_summary$treated_mean - gene_summary$control_mean

gene_summary

# 평균 차이의 절댓값이 큰 순서로 정렬하세요.
gene_order <- order(
  abs(gene_summary$difference),
  decreasing = TRUE
)

gene_summary_sorted <- gene_summary[gene_order, ]
gene_summary_sorted

# 요약값의 소수점 자릿수를 정리하세요.
gene_summary_sorted$control_mean <-
  round(gene_summary_sorted$control_mean, digits = 2)

gene_summary_sorted$treated_mean <-
  round(gene_summary_sorted$treated_mean, digits = 2)

gene_summary_sorted$difference <-
  round(gene_summary_sorted$difference, digits = 2)

gene_summary_sorted

# TODO: treated 평균이 control 평균보다 큰 유전자만 선택하세요.
# TODO: 평균 차이가 가장 큰 유전자 이름을 확인하세요.


# 7단계: QC 지표와 발현 결과 시각화하기 ----------------------------

# 조건별 QC 통과 샘플 수를 막대그래프로 표시하세요.
barplot(
  analysis_condition_counts,
  main = "조건별 QC 통과 샘플 수",
  xlab = "실험 조건",
  ylab = "샘플 수",
  col = c("#4472C4", "#ED7D31")
)

# 전체 샘플의 조건별 세포 수를 상자그림으로 비교하세요.
boxplot(
  cell_count ~ condition,
  data = sample_metadata,
  main = "실험 조건별 세포 수",
  xlab = "실험 조건",
  ylab = "세포 수",
  col = c("#4472C4", "#ED7D31")
)

# 조건에 따라 산점도 점 색상을 만드세요.
point_colors <- ifelse(
  sample_metadata$condition == "control",
  "#4472C4",
  "#ED7D31"
)

# 세포 수와 검출 유전자 수의 관계를 표시하세요.
plot(
  sample_metadata$cell_count,
  sample_metadata$median_genes,
  main = "세포 수와 검출 유전자 수의 관계",
  xlab = "세포 수",
  ylab = "검출 유전자 수 중앙값",
  pch = 19,
  col = point_colors
)

legend(
  "bottomright",
  legend = c("control", "treated"),
  col = c("#4472C4", "#ED7D31"),
  pch = 19
)

# 선택한 유전자의 조건별 평균 발현량을 표시하세요.
selected_gene <- "CD3D"

selected_row <- gene_summary[
  gene_summary$gene_id == selected_gene,
]

selected_means <- c(
  control = selected_row$control_mean,
  treated = selected_row$treated_mean
)

barplot(
  selected_means,
  main = paste(selected_gene, "조건별 평균 발현량"),
  xlab = "실험 조건",
  ylab = "평균 발현량",
  col = c("#4472C4", "#ED7D31")
)

# TODO: gene_summary_sorted의 첫 번째 유전자를 선택하여
# TODO: 조건별 평균 발현 막대그래프를 작성하세요.


# 8단계: 분석 결과를 CSV와 PNG로 저장하기 --------------------------

dir.create("results", showWarnings = FALSE)

# QC 결과가 포함된 전체 메타데이터를 저장하세요.
metadata_qc_path <- "results/project_metadata_qc.csv"
write.csv(sample_metadata, metadata_qc_path, row.names = FALSE)

# 분석에 사용한 메타데이터를 저장하세요.
analysis_metadata_path <- "results/project_analysis_metadata.csv"
write.csv(
  analysis_metadata,
  analysis_metadata_path,
  row.names = FALSE
)

# 정렬된 유전자 요약표를 저장하세요.
gene_summary_path <- "results/project_gene_summary.csv"
write.csv(
  gene_summary_sorted,
  gene_summary_path,
  row.names = FALSE
)

# 선택한 유전자 그래프를 저장하세요.
gene_plot_path <- "results/project_gene_expression.png"

png(
  gene_plot_path,
  width = 900,
  height = 600,
  res = 120
)

barplot(
  selected_means,
  main = paste(selected_gene, "조건별 평균 발현량"),
  xlab = "실험 조건",
  ylab = "평균 발현량",
  col = c("#4472C4", "#ED7D31")
)

dev.off()

# 결과 파일이 생성됐는지 확인하세요.
file.exists(metadata_qc_path)
file.exists(analysis_metadata_path)
file.exists(gene_summary_path)
file.exists(gene_plot_path)

# TODO: QC 지표 산점도를 results/project_qc_scatter.png로 저장하세요.


# 9단계: 프로젝트 전체를 RDS로 저장하기 ----------------------------

# 결과와 분석 기준을 하나의 리스트로 정리하세요.
project_result <- list(
  metadata_all = sample_metadata,
  metadata_analysis = analysis_metadata,
  expression_analysis = analysis_expression,
  gene_summary = gene_summary_sorted,
  parameters = qc_parameters
)

names(project_result)
str(project_result, max.level = 2)

# 프로젝트 객체를 저장하세요.
project_rds_path <- "results/transcriptomics_project.rds"
saveRDS(project_result, project_rds_path)
file.exists(project_rds_path)

# 저장한 객체를 다시 불러오세요.
restored_project <- readRDS(project_rds_path)

# 저장 전후의 객체가 같은지 확인하세요.
identical(project_result, restored_project)
str(restored_project, max.level = 2)


# 10단계: 저장 결과 다시 읽어 검증하기 -----------------------------

# 저장한 CSV 파일을 다시 불러오세요.
saved_analysis_metadata <- read.csv(analysis_metadata_path)
saved_gene_summary <- read.csv(gene_summary_path)

# 저장 전후의 행 수와 열 이름을 비교하세요.
nrow(analysis_metadata)
nrow(saved_analysis_metadata)

names(analysis_metadata)
names(saved_analysis_metadata)

nrow(gene_summary_sorted)
nrow(saved_gene_summary)

names(gene_summary_sorted)
names(saved_gene_summary)

# 핵심 결과가 예상과 같은지 확인하세요.
stopifnot(nrow(analysis_metadata) == nrow(saved_analysis_metadata))
stopifnot(nrow(gene_summary_sorted) == nrow(saved_gene_summary))
stopifnot(identical(project_result, restored_project))


# 프로젝트 해석과 한계 기록하기 -------------------------------------

# TODO: QC를 통과한 전체 샘플 수를 주석으로 기록하세요.
# TODO: 조건별 QC 통과 샘플 수를 주석으로 기록하세요.
# TODO: 평균 발현 차이의 절댓값이 가장 큰 유전자를 기록하세요.
# TODO: 선택한 유전자의 control과 treated 평균을 기록하세요.
# TODO: 아래 한계를 자신의 말로 설명하세요.
# - 합성 데이터이며 샘플과 유전자 수가 적음
# - 정규화와 배치 보정을 수행하지 않음
# - 통계 검정과 다중 검정 보정을 수행하지 않음
# - 평균 차이를 실제 차등 발현 결과로 해석할 수 없음


# 최종 점검 ------------------------------------------------------------

# TODO: 스크립트를 깨끗한 R 세션에서 위에서 아래로 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 두 입력 파일의 샘플 이름과 순서가 일치하는지 확인하세요.
# TODO: results 폴더의 CSV, PNG, RDS 파일을 직접 열어 확인하세요.
# TODO: 분석 기준, 결과, 한계를 다른 사람에게 설명해 보세요.
# TODO: 파일을 저장하세요.
