-- run this to create missing tables in results schema
-- http://www.ohdsi.org/web/wiki/doku.php?id=documentation:software:webapi:multiple_datasets_configuration
CREATE TABLE omop_cdm_parquet.cohort_inclusion(
  cohort_definition_id int,
  rule_sequence int,
  name varchar(255),
  description varchar(1000)
)
;

CREATE TABLE omop_cdm_parquet.cohort_inclusion_result(
  cohort_definition_id int,
  inclusion_rule_mask bigint,
  person_count bigint
)
;

CREATE TABLE omop_cdm_parquet.cohort_inclusion_stats(
  cohort_definition_id int,
  rule_sequence int,
  person_count bigint,
  gain_count bigint,
  person_total bigint
)
;

CREATE TABLE omop_cdm_parquet.cohort_summary_stats(
  cohort_definition_id int,
  base_count bigint,
  final_count bigint
)
;

CREATE TABLE omop_cdm_parquet.feas_study_result(
  study_id int,
  inclusion_rule_mask bigint,
  person_count bigint
)
;

CREATE TABLE omop_cdm_parquet.feas_study_index_stats(
  study_id int,
  person_count bigint,
  match_count bigint
)
;

CREATE TABLE omop_cdm_parquet.feas_study_inclusion_stats(
  study_id int,
  rule_sequence int,
  name varchar(255),
  person_count bigint,
  gain_count bigint,
  person_total bigint
)
;

create table omop_cdm_parquet.heracles_analysis
(
	analysis_id int,
	analysis_name varchar(255),
	stratum_1_name varchar(255),
	stratum_2_name varchar(255),
	stratum_3_name varchar(255),
	stratum_4_name varchar(255),
	stratum_5_name varchar(255),
	analysis_type varchar(255)
);

CREATE TABLE omop_cdm_parquet.HERACLES_HEEL_results
(
cohort_definition_id int,
analysis_id INT,
HERACLES_HEEL_warning VARCHAR(255)
);

create table omop_cdm_parquet.heracles_results
(
	cohort_definition_id int,
	analysis_id int,
	stratum_1 varchar(255),
	stratum_2 varchar(255),
	stratum_3 varchar(255),
	stratum_4 varchar(255),
	stratum_5 varchar(255),
	count_value bigint,
	last_update_time timestamp -- DEFAULT (now())
);


create table omop_cdm_parquet.heracles_results_dist
(
	cohort_definition_id int,
	analysis_id int,
	stratum_1 varchar(255),
	stratum_2 varchar(255),
	stratum_3 varchar(255),
	stratum_4 varchar(255),
	stratum_5 varchar(255),
	count_value bigint,
	min_value float,
	max_value float,
	avg_value float,
	stdev_value float,
	median_value float,
	p10_value float,
	p25_value float,
	p75_value float,
	p90_value float,
	last_update_time timestamp -- DEFAULT (now())
);

CREATE TABLE omop_cdm_parquet.ir_analysis_dist (
  analysis_id int,
  target_id int,
  outcome_id int,
  strata_sequence INT,
  dist_type int,
  total bigint,
  avg_value float,
  std_dev float,
  min_value int,
  p10_value int,
  p25_value int,
  median_value int,
  p75_value int,
  p90_value int,
  max_value int
)
;

CREATE TABLE omop_cdm_parquet.ir_strata(
  analysis_id int,
  strata_sequence int,
  name varchar(255),
  description varchar(1000)
)
;

CREATE TABLE omop_cdm_parquet.ir_analysis_result(
  analysis_id int,
  target_id int,
  outcome_id int,
  strata_mask bigint,
  person_count bigint,
  time_at_risk bigint,
  cases bigint
)
;

CREATE TABLE omop_cdm_parquet.ir_analysis_strata_stats(
  analysis_id int,
  target_id int,
  outcome_id int,
  strata_sequence int,
  person_count bigint,
  time_at_risk bigint,
  cases bigint
)
;
