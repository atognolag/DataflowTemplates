CREATE TABLE all_data_types (
                                primary_key STRING(MAX) NOT NULL,
                                ascii_col STRING(MAX),
                                bigint_col INT64,
                                blob_col BYTES(MAX),
                                boolean_col BOOL,
                                date_col DATE,
                                decimal_col NUMERIC,
                                double_col FLOAT64,
                                duration_col STRING(MAX),
                                float_col FLOAT32,
                                frozen_ascii_list_col ARRAY<STRING(MAX)>,
                                frozen_ascii_set_col ARRAY<STRING(MAX)>,
                                inet_col STRING(MAX),
                                int_col INT64,
                                smallint_col INT64,
                                text_col STRING(MAX),
                                time_col STRING(MAX),
                                timestamp_col TIMESTAMP,
                                timeuuid_col STRING(MAX),
                                tinyint_col INT64,
                                uuid_col STRING(MAX),
                                varchar_col STRING(MAX),
                                varint_col NUMERIC,
                                ascii_list_col ARRAY<STRING(MAX)>,
                                ascii_set_col ARRAY<STRING(MAX)>,
                                ascii_text_map_col JSON,
                                bigint_boolean_map_col JSON,
                                bigint_list_col ARRAY<INT64>,
                                bigint_set_col ARRAY<INT64>,
                                blob_int_map_col JSON,
                                blob_list_col ARRAY<BYTES(MAX)>,
                                blob_set_col ARRAY<BYTES(MAX)>,
                                boolean_decimal_map_col JSON,
                                boolean_list_col ARRAY<BOOL>,
                                boolean_set_col ARRAY<BOOL>,
                                date_double_map_col JSON,
                                date_list_col ARRAY<DATE>,
                                date_set_col ARRAY<DATE>,
                                decimal_duration_map_col JSON,
                                decimal_list_col ARRAY<NUMERIC>,
                                decimal_set_col ARRAY<NUMERIC>,
                                double_float_map_col JSON,
                                double_inet_map_col JSON,
                                double_list_col ARRAY<FLOAT64>,
                                double_set_col ARRAY<FLOAT64>,
                                duration_list_col ARRAY<STRING(MAX)>,
                                float_list_col ARRAY<FLOAT32>,
                                float_set_col ARRAY<FLOAT32>,
                                float_smallint_map_col JSON,
                                inet_list_col ARRAY<STRING(MAX)>,
                                inet_set_col ARRAY<STRING(MAX)>,
                                inet_text_map_col JSON,
                                int_list_col ARRAY<INT64>,
                                int_set_col ARRAY<INT64>,
                                int_time_map_col JSON,
                                smallint_list_col ARRAY<INT64>,
                                smallint_set_col ARRAY<INT64>,
                                smallint_timestamp_map_col JSON,
                                text_list_col ARRAY<STRING(MAX)>,
                                text_set_col ARRAY<STRING(MAX)>,
                                text_timeuuid_map_col JSON,
                                time_list_col ARRAY<STRING(MAX)>,
                                time_set_col ARRAY<STRING(MAX)>,
                                time_tinyint_map_col JSON,
                                timestamp_list_col ARRAY<TIMESTAMP>,
                                timestamp_set_col ARRAY<TIMESTAMP>,
                                timestamp_uuid_map_col JSON,
                                timeuuid_list_col ARRAY<STRING(MAX)>,
                                timeuuid_set_col ARRAY<STRING(MAX)>,
                                timeuuid_varchar_map_col JSON,
                                tinyint_list_col ARRAY<INT64>,
                                tinyint_set_col ARRAY<INT64>,
                                tinyint_varint_map_col JSON,
                                uuid_ascii_map_col JSON,
                                uuid_list_col ARRAY<STRING(MAX)>,
                                uuid_set_col ARRAY<STRING(MAX)>,
                                varchar_bigint_map_col JSON,
                                varchar_list_col ARRAY<STRING(MAX)>,
                                varchar_set_col ARRAY<STRING(MAX)>,
                                varint_blob_map_col JSON,
                                varint_list_col ARRAY<NUMERIC>,
                                varint_set_col ARRAY<NUMERIC>,
) PRIMARY KEY(primary_key);