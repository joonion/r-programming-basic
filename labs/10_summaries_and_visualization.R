# 10차시 실습: 데이터 요약과 시각화

# 이름:
# 날짜:


# 실습 준비: 샘플 메타데이터 불러오기 -------------------------------

input_path <- "data/sample_metadata.csv"
file.exists(input_path)

sample_metadata <- read.csv(input_path)
head(sample_metadata)
str(sample_metadata)

dir.create("results", showWarnings = FALSE)


# 실습 1: 숫자형 변수 전체 요약하기 ----------------------------------

cell_counts <- sample_metadata$cell_count

# 전체 요약 정보를 확인하세요.
summary(cell_counts)

# 중심과 범위를 나타내는 값을 계산하세요.
mean(cell_counts)
median(cell_counts)
min(cell_counts)
max(cell_counts)
range(cell_counts)

# 퍼진 정도를 나타내는 값을 계산하세요.
quantile(cell_counts)
IQR(cell_counts)
sd(cell_counts)

# TODO: median_genes의 평균, 중앙값, 범위, 표준편차를 계산하세요.


# 실습 2: 결측값이 있는 변수 요약하기 -------------------------------

doublet_rates <- sample_metadata$doublet_rate

# 결측값의 위치와 개수를 확인하세요.
is.na(doublet_rates)
sum(is.na(doublet_rates))

# 결측값을 제외하기 전후의 결과를 비교하세요.
mean(doublet_rates)
mean(doublet_rates, na.rm = TRUE)
median(doublet_rates, na.rm = TRUE)

# TODO: doublet_rate의 최솟값과 최댓값을
# TODO: 결측값을 제외하고 계산하세요.


# 실습 3: 범주형 변수의 개수와 비율 요약하기 ------------------------

# 실험 조건별 샘플 수를 계산하세요.
condition_counts <- table(sample_metadata$condition)
condition_counts

# 각 조건의 비율을 계산하세요.
prop.table(condition_counts)

# 조건과 QC 통과 여부를 함께 교차 집계하세요.
condition_qc_counts <- table(
  sample_metadata$condition,
  sample_metadata$passed_qc
)
condition_qc_counts

# TODO: batch별 샘플 수와 비율을 계산하세요.


# 실습 4: tapply()로 그룹별 요약하기 ---------------------------------

# 조건별 평균 세포 수를 계산하세요.
mean_cell_counts <- tapply(
  sample_metadata$cell_count,
  sample_metadata$condition,
  mean
)
mean_cell_counts

# 조건별 중앙값과 표준편차를 계산하세요.
median_cell_counts <- tapply(
  sample_metadata$cell_count,
  sample_metadata$condition,
  median
)

sd_cell_counts <- tapply(
  sample_metadata$cell_count,
  sample_metadata$condition,
  sd
)

median_cell_counts
sd_cell_counts

# 결측값을 제외하고 조건별 평균 doublet_rate를 계산하세요.
mean_doublet_rates <- tapply(
  sample_metadata$doublet_rate,
  sample_metadata$condition,
  mean,
  na.rm = TRUE
)
mean_doublet_rates

# TODO: batch별 median_genes 평균을 계산하세요.


# 실습 5: aggregate()로 그룹별 요약표 만들기 ------------------------

# 여러 숫자형 열의 조건별 평균을 계산하세요.
condition_summary <- aggregate(
  cbind(cell_count, median_genes, mito_percent) ~ condition,
  data = sample_metadata,
  FUN = mean
)

condition_summary

# 그룹별 샘플 수를 추가하세요.
condition_summary$sample_count <- as.integer(
  condition_counts[condition_summary$condition]
)

# 표시할 소수점 자릿수를 정리하세요.
condition_summary$cell_count <-
  round(condition_summary$cell_count, digits = 1)

condition_summary$median_genes <-
  round(condition_summary$median_genes, digits = 1)

condition_summary$mito_percent <-
  round(condition_summary$mito_percent, digits = 2)

condition_summary

# TODO: batch별 cell_count와 median_genes 평균을 계산한
# TODO: batch_summary 데이터 프레임을 만드세요.


# 실습 6: 막대그래프 작성하기 ----------------------------------------

# 조건별 샘플 수를 막대그래프로 표시하세요.
barplot(
  condition_counts,
  main = "실험 조건별 샘플 수",
  xlab = "실험 조건",
  ylab = "샘플 수",
  col = c("#4472C4", "#ED7D31")
)

# 조건별 평균 세포 수를 막대그래프로 표시하세요.
barplot(
  mean_cell_counts,
  main = "조건별 평균 세포 수",
  xlab = "실험 조건",
  ylab = "평균 세포 수",
  col = c("#4472C4", "#ED7D31")
)

# TODO: batch별 샘플 수를 막대그래프로 표시하세요.
# TODO: 제목과 축 이름을 추가하세요.


# 실습 7: 히스토그램 작성하기 ----------------------------------------

# 세포 수 분포를 히스토그램으로 표시하세요.
hist(
  sample_metadata$cell_count,
  breaks = 4,
  main = "샘플별 세포 수 분포",
  xlab = "세포 수",
  ylab = "빈도",
  col = "#70AD47",
  border = "white"
)

# TODO: median_genes 분포의 히스토그램을 작성하세요.
# TODO: 제목, 축 이름, 색상을 지정하세요.


# 실습 8: 그룹별 상자그림 작성하기 ----------------------------------

# 조건별 세포 수를 상자그림으로 비교하세요.
boxplot(
  cell_count ~ condition,
  data = sample_metadata,
  main = "실험 조건별 세포 수",
  xlab = "실험 조건",
  ylab = "세포 수",
  col = c("#4472C4", "#ED7D31")
)

# TODO: 조건별 mito_percent를 상자그림으로 비교하세요.
# TODO: 표본 수가 적을 때 해석에 주의할 점을 주석으로 적으세요.


# 실습 9: 산점도와 범례 작성하기 ------------------------------------

# 조건에 따라 점 색상을 지정하세요.
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

# 색상의 의미를 설명하는 범례를 추가하세요.
legend(
  "bottomright",
  legend = c("control", "treated"),
  col = c("#4472C4", "#ED7D31"),
  pch = 19
)

# TODO: median_genes와 mito_percent의 산점도를 작성하세요.
# TODO: 제목과 축 이름을 추가하고 조건에 따라 점 색상을 지정하세요.


# 실습 10: 요약표와 그래프 저장하기 ----------------------------------

# 조건별 요약표를 CSV 파일로 저장하세요.
summary_path <- "results/condition_summary.csv"

write.csv(
  condition_summary,
  summary_path,
  row.names = FALSE
)

file.exists(summary_path)

# 저장한 요약표를 다시 불러와 확인하세요.
saved_summary <- read.csv(summary_path)
saved_summary
str(saved_summary)

# 조건별 세포 수 상자그림을 PNG 파일로 저장하세요.
plot_path <- "results/cell_count_by_condition.png"

png(
  plot_path,
  width = 900,
  height = 600,
  res = 120
)

boxplot(
  cell_count ~ condition,
  data = sample_metadata,
  main = "실험 조건별 세포 수",
  xlab = "실험 조건",
  ylab = "세포 수",
  col = c("#4472C4", "#ED7D31")
)

dev.off()
file.exists(plot_path)

# TODO: 산점도를 results/cell_count_vs_genes.png로 저장하세요.
# TODO: 저장한 PNG 파일을 직접 열어 제목과 축을 확인하세요.


# 마무리 연습: 질문에 맞는 요약과 그래프 만들기 --------------------

# 질문: control과 treated 조건의 mito_percent는 어떻게 다른가?

# TODO: 조건별 mito_percent의 평균과 중앙값을 계산하세요.
# TODO: 결과를 하나의 데이터 프레임으로 정리하세요.
# TODO: 조건별 분포를 비교할 수 있는 그래프를 선택해 작성하세요.
# TODO: 그래프 제목, 축 이름, 색상을 지정하세요.
# TODO: 요약표와 그래프를 results 폴더에 저장하세요.
# TODO: 샘플 수가 적다는 해석상의 제한점을 주석으로 기록하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 표와 그래프의 제목 및 축 이름이 내용을 정확히 설명하는지 확인하세요.
# TODO: results 폴더의 CSV와 PNG 파일을 직접 열어 확인하세요.
# TODO: 파일을 저장하세요.
