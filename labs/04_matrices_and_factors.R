# 4차시 실습: 행렬과 팩터

# 이름:
# 날짜:


# 실습 1: 작은 유전자 발현 행렬 만들기 ------------------------------

# 세 유전자와 세 세포의 교육용 발현값을 행렬로 만드세요.
expression_matrix <- matrix(
  c(
    5, 0, 3,
    1, 4, 0,
    0, 2, 6
  ),
  nrow = 3,
  ncol = 3,
  byrow = TRUE
)

expression_matrix

# 행과 열의 개수, 전체 원소 수를 확인하세요.
dim(expression_matrix)
nrow(expression_matrix)
ncol(expression_matrix)
length(expression_matrix)

# 행렬의 클래스와 내부 자료형을 확인하세요.
class(expression_matrix)
typeof(expression_matrix)


# 실습 2: 행과 열 이름 붙이기 ----------------------------------------

# 행에는 유전자 이름을 붙이세요.
rownames(expression_matrix) <- c(
  "MS4A1",
  "CD3D",
  "LYZ"
)

# 열에는 세포 이름을 붙이세요.
colnames(expression_matrix) <- c(
  "cell_1",
  "cell_2",
  "cell_3"
)

expression_matrix
rownames(expression_matrix)
colnames(expression_matrix)

# TODO: 행 이름과 열 이름의 길이가 행 수 및 열 수와 같은지 확인하세요.


# 실습 3: 위치와 이름으로 원소 선택하기 -----------------------------

# 첫 번째 행, 두 번째 열의 원소를 위치로 선택하세요.
expression_matrix[1, 2]

# 같은 원소를 이름으로 선택하세요.
expression_matrix["MS4A1", "cell_2"]

# MS4A1의 모든 세포 값을 선택하세요.
expression_matrix["MS4A1", ]

# cell_2의 모든 유전자 값을 선택하세요.
expression_matrix[, "cell_2"]

# 두 유전자와 두 세포를 함께 선택하세요.
expression_matrix[
  c("MS4A1", "LYZ"),
  c("cell_1", "cell_3")
]

# TODO: CD3D의 cell_3 값을 이름으로 선택하세요.
# TODO: MS4A1과 CD3D의 모든 세포 값을 선택하세요.


# 실습 4: 행렬 구조 유지하기 -----------------------------------------

# 한 행을 기본 방식으로 선택하고 구조를 확인하세요.
one_gene_vector <- expression_matrix["MS4A1", ]
one_gene_vector
class(one_gene_vector)
dim(one_gene_vector)

# drop = FALSE로 행렬 구조를 유지하세요.
one_gene_matrix <- expression_matrix[
  "MS4A1",
  ,
  drop = FALSE
]

one_gene_matrix
class(one_gene_matrix)
dim(one_gene_matrix)

# TODO: cell_1 한 열을 행렬로 유지하여 one_cell_matrix에 저장하세요.


# 실습 5: 행렬의 값 계산하고 선택하기 -------------------------------

# 모든 원소에 같은 계산을 적용하세요.
expression_matrix + 1
expression_matrix * 2

# 3보다 큰지 각 원소를 비교하세요.
high_expression <- expression_matrix > 3
high_expression

# 조건을 만족하는 값만 선택하세요.
expression_matrix[high_expression]

# TODO: 0인 원소의 개수를 계산하세요.
# 힌트: sum(expression_matrix == 0)


# 실습 6: 행과 열 방향으로 요약하기 ---------------------------------

# 유전자별 전체 발현량과 평균을 계산하세요.
gene_totals <- rowSums(expression_matrix)
gene_means <- rowMeans(expression_matrix)

gene_totals
gene_means

# 세포별 전체 count와 평균을 계산하세요.
cell_totals <- colSums(expression_matrix)
cell_means <- colMeans(expression_matrix)

cell_totals
cell_means

# apply()로 행별 및 열별 최댓값을 계산하세요.
apply(expression_matrix, 1, max)
apply(expression_matrix, 2, max)

# TODO: 어떤 유전자의 전체 발현량이 가장 큰지 확인하세요.
# TODO: 어떤 세포의 전체 count가 가장 큰지 확인하세요.


# 실습 7: 문자형 벡터와 팩터 비교하기 -------------------------------

condition_text <- c(
  "control",
  "control",
  "treated"
)

condition_factor <- factor(
  condition_text,
  levels = c("control", "treated")
)

condition_text
condition_factor

class(condition_text)
class(condition_factor)

levels(condition_factor)
nlevels(condition_factor)
table(condition_factor)

# TODO: condition_factor를 다시 문자형으로 변환하세요.


# 실습 8: 관측되지 않은 수준과 droplevels() -------------------------

# 세 수준 중 cluster 2는 현재 관측되지 않은 상황입니다.
cluster_ids <- factor(
  c("0", "1", "1"),
  levels = c("0", "1", "2")
)

cluster_ids
levels(cluster_ids)
table(cluster_ids)

# 사용되지 않는 수준을 제거하세요.
observed_clusters <- droplevels(cluster_ids)
observed_clusters
levels(observed_clusters)

# TODO: 제거 전후의 수준 개수를 비교하세요.


# 실습 9: 팩터 수준 순서 지정하기 -----------------------------------

cell_types <- factor(
  c("B cell", "T cell", "Monocyte", "T cell"),
  levels = c("T cell", "B cell", "Monocyte")
)

cell_types
levels(cell_types)
table(cell_types)

# 기준 수준을 B cell로 바꾸세요.
cell_types_releveled <- relevel(
  cell_types,
  ref = "B cell"
)

levels(cell_types_releveled)

# TODO: Monocyte를 첫 번째 수준으로 바꾸세요.


# 실습 10: 숫자처럼 보이는 팩터 변환하기 ----------------------------

score_factor <- factor(c("10", "20", "30"))

# 잘못된 변환 결과를 확인하세요.
as.numeric(score_factor)

# 문자형을 거쳐 실제 숫자값으로 변환하세요.
score_number <- as.numeric(as.character(score_factor))
score_number

# 예상한 숫자와 같은지 확인하세요.
identical(score_number, c(10, 20, 30))


# 마무리 연습: Seurat 준비 구조 만들기 -------------------------------

# 네 세포의 작은 count matrix를 만드세요.
count_matrix <- matrix(
  c(
    4, 0, 2, 1,
    0, 5, 3, 4,
    2, 1, 0, 6
  ),
  nrow = 3,
  byrow = TRUE
)

rownames(count_matrix) <- c("MS4A1", "CD3D", "LYZ")
colnames(count_matrix) <- c("cell_A", "cell_B", "cell_C", "cell_D")

cell_clusters <- factor(
  c("0", "1", "0", "2"),
  levels = c("0", "1", "2")
)

# TODO: count_matrix의 행 수와 열 수를 확인하세요.
# TODO: 세포별 전체 count를 계산하세요.
# TODO: cluster별 세포 수를 계산하세요.
# TODO: MS4A1의 모든 세포 count를 선택하세요.
# TODO: cluster 0인 세포의 열 이름을 선택하세요.
# 힌트: colnames(count_matrix)[cell_clusters == "0"]
# TODO: cluster 0인 세포의 count matrix만 선택하세요.
# TODO: 결과가 행렬로 유지되는지 확인하세요.


# 종료 점검 ------------------------------------------------------------

# TODO: 오늘 작성한 모든 코드를 위에서 아래로 다시 실행하세요.
# TODO: 의도하지 않은 오류나 경고가 없는지 확인하세요.
# TODO: 행과 열 방향이 예상한 의미와 일치하는지 확인하세요.
# TODO: 팩터의 값과 수준을 구분해 설명해 보세요.
# TODO: 파일을 저장하세요.
