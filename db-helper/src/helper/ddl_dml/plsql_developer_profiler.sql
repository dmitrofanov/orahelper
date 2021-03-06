-- Create table
CREATE TABLE PRFLR$PLSQL_PROFILER_DATA
(
  runid       NUMBER NOT NULL,
  unit_number NUMBER NOT NULL,
  line#       NUMBER NOT NULL,
  total_occur NUMBER,
  total_time  NUMBER,
  min_time    NUMBER,
  max_time    NUMBER,
  spare1      NUMBER,
  spare2      NUMBER,
  spare3      NUMBER,
  spare4      NUMBER
)
/
-- Create table
CREATE TABLE PRFLR$PLSQL_PROFILER_RUNS
(
  runid           NUMBER NOT NULL,
  related_run     NUMBER,
  run_owner       VARCHAR2(32),
  run_date        DATE,
  run_comment     VARCHAR2(2047),
  run_total_time  NUMBER,
  run_system_info VARCHAR2(2047),
  run_comment1    VARCHAR2(2047),
  spare1          VARCHAR2(256)
)
/ 
-- Create table
CREATE TABLE PRFLR$PLSQL_PROFILER_UNITS
(
  runid          NUMBER NOT NULL,
  unit_number    NUMBER NOT NULL,
  unit_type      VARCHAR2(32),
  unit_owner     VARCHAR2(32),
  unit_name      VARCHAR2(32),
  unit_timestamp DATE,
  total_time     NUMBER DEFAULT 0 NOT NULL,
  spare1         NUMBER,
  spare2         NUMBER
)
/
-- Add comments to the table 
COMMENT ON TABLE PRFLR$PLSQL_PROFILER_RUNS
  IS 'Run-specific information for the PL/SQL profiler'
/
-- Create/Recreate primary, unique and foreign key constraints 
ALTER TABLE PRFLR$PLSQL_PROFILER_RUNS
  ADD PRIMARY KEY (RUNID)
  USING INDEX
/
-- Add comments to the table 
COMMENT ON TABLE PRFLR$PLSQL_PROFILER_UNITS
  IS 'Information about each library unit in a run'
/
-- Create/Recreate primary, unique and foreign key constraints 
ALTER TABLE PRFLR$PLSQL_PROFILER_UNITS
  ADD PRIMARY KEY (RUNID, UNIT_NUMBER)
  USING INDEX
/
ALTER TABLE PRFLR$PLSQL_PROFILER_UNITS
  ADD FOREIGN KEY (RUNID)
  REFERENCES PRFLR$PLSQL_PROFILER_RUNS (RUNID)
/
-- Add comments to the table 
COMMENT ON TABLE PRFLR$PLSQL_PROFILER_DATA
  IS 'Accumulated data from all profiler runs'
/
-- Create/Recreate primary, unique and foreign key constraints 
ALTER TABLE PRFLR$PLSQL_PROFILER_DATA
  ADD PRIMARY KEY (RUNID, UNIT_NUMBER, LINE#)
  USING INDEX
/
ALTER TABLE PRFLR$PLSQL_PROFILER_DATA
  ADD FOREIGN KEY (RUNID, UNIT_NUMBER)
  REFERENCES PRFLR$PLSQL_PROFILER_UNITS (RUNID, UNIT_NUMBER)
/
-- Create sequence 
CREATE SEQUENCE PRFLR$PLSQL_PROFILER_RUNNUMBER
/
-- Public synonyms
CREATE OR REPLACE PUBLIC SYNONYM PLSQL_PROFILER_DATA FOR PRFLR$PLSQL_PROFILER_DATA
/
CREATE OR REPLACE PUBLIC SYNONYM PLSQL_PROFILER_RUNS FOR PRFLR$PLSQL_PROFILER_RUNS
/
CREATE OR REPLACE PUBLIC SYNONYM PLSQL_PROFILER_UNITS FOR PRFLR$PLSQL_PROFILER_UNITS
/
CREATE OR REPLACE PUBLIC SYNONYM PLSQL_PROFILER_RUNNUMBER FOR PRFLR$PLSQL_PROFILER_RUNNUMBER
/
-- Public grants
GRANT SELECT, INSERT, UPDATE, DELETE ON PRFLR$PLSQL_PROFILER_DATA TO PUBLIC
/
GRANT SELECT, INSERT, UPDATE, DELETE ON PRFLR$PLSQL_PROFILER_RUNS TO PUBLIC
/
GRANT SELECT, INSERT, UPDATE, DELETE ON PRFLR$PLSQL_PROFILER_UNITS TO PUBLIC
/
GRANT SELECT, ALTER ON PRFLR$PLSQL_PROFILER_RUNNUMBER TO PUBLIC
/



