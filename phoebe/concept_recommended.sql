DROP TABLE IF EXISTS :vocab_schema.concept_recommended;
CREATE TABLE :vocab_schema.concept_recommended
(
    concept_id_1 bigint,
    concept_id_2 bigint,
    relationship_id character varying(20)
)