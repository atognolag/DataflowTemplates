/*
 * Copyright (C) 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
package com.google.cloud.teleport.v2.spanner.migrations.schema;

import com.google.cloud.teleport.v2.spanner.migrations.exceptions.DroppedTableException;
import java.io.Serializable;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * Schema object to store mapping information as per the session file generated by HarbourBridge.
 */
public class Schema implements Serializable {
  /** Maps the HarbourBridge table ID to the Spanner table details. */
  private final Map<String, SpannerTable> spSchema;

  /** Maps the Spanner table ID to the synthetic PK. */
  private final Map<String, SyntheticPKey> syntheticPKeys;

  /** Maps the HarbourBridge table ID to the Source table details. */
  private final Map<String, SourceTable> srcSchema;

  // The columns below are not part of the session file. They are computed based on the fields
  // above.
  /** Maps the source table name to the Spanner table name and column names. */
  private Map<String, NameAndCols> toSpanner;

  /** Maps the Spanner table name to the source table name and column names. */
  private Map<String, NameAndCols> toSource;

  /** Maps the source table and cols to the HarbourBridge internal ID. */
  private Map<String, NameAndCols> srcToID;

  /** Maps the spanner table and cols to the HarbourBridge internal ID. */
  private Map<String, NameAndCols> spannerToID;

  /** Denotes whether the Schema is empty or not. */
  private boolean empty;

  public Schema() {
    this.spSchema = new HashMap<String, SpannerTable>();
    this.syntheticPKeys = new HashMap<String, SyntheticPKey>();
    this.srcSchema = new HashMap<String, SourceTable>();
    this.toSpanner = new HashMap<String, NameAndCols>();
    this.toSource = new HashMap<String, NameAndCols>();
    this.srcToID = new HashMap<String, NameAndCols>();
    this.spannerToID = new HashMap<String, NameAndCols>();
    this.empty = true;
  }

  public Schema(
      Map<String, SpannerTable> spSchema,
      Map<String, SyntheticPKey> syntheticPKeys,
      Map<String, SourceTable> srcSchema,
      Map<String, NameAndCols> toSpanner,
      Map<String, NameAndCols> toSource) {
    this.spSchema = spSchema;
    this.syntheticPKeys = syntheticPKeys;
    this.srcSchema = srcSchema;
    this.toSpanner = toSpanner;
    this.toSource = toSource;
    this.empty = (spSchema == null || srcSchema == null);
  }

  public Schema(
      Map<String, SpannerTable> spSchema,
      Map<String, SyntheticPKey> syntheticPKeys,
      Map<String, SourceTable> srcSchema) {
    this.spSchema = spSchema;
    this.syntheticPKeys = syntheticPKeys;
    this.srcSchema = srcSchema;
    this.empty = (spSchema == null || srcSchema == null);
  }

  public Map<String, SpannerTable> getSpSchema() {
    return spSchema;
  }

  public Map<String, SyntheticPKey> getSyntheticPks() {
    return syntheticPKeys;
  }

  public Map<String, SourceTable> getSrcSchema() {
    return srcSchema;
  }

  public Map<String, NameAndCols> getToSpanner() {
    return toSpanner;
  }

  public void setToSpanner(Map<String, NameAndCols> toSpanner) {
    this.toSpanner = toSpanner;
  }

  public Map<String, NameAndCols> getToSource() {
    return toSource;
  }

  public void setToSource(Map<String, NameAndCols> toSource) {
    this.toSource = toSource;
  }

  public Map<String, NameAndCols> getSrcToID() {
    return srcToID;
  }

  public void setSrcToID(Map<String, NameAndCols> srcToID) {
    this.srcToID = srcToID;
  }

  public Map<String, NameAndCols> getSpannerToID() {
    return spannerToID;
  }

  public void setSpannerToID(Map<String, NameAndCols> spannerToID) {
    this.spannerToID = spannerToID;
  }

  public void generateMappings() {
    this.computeToSpanner();
    this.computeToSource();
    this.computeSrcToID();
    this.computeSpannerToID();
  }

  public void computeToSpanner() {
    // We iterate over spSchema because srcSchema might have extra tables that were dropped.
    for (String tableId : spSchema.keySet()) {
      SpannerTable spTable = spSchema.get(tableId);
      SourceTable srcTable = srcSchema.get(tableId);
      Map<String, String> cols = new HashMap<String, String>();
      // We iterate over spTable columns because the source might have extra columns that were
      // dropped. We only keep those columns present both in source and in spanner.
      for (String colId : spTable.getColIds()) {
        // We add this check because spanner can have extra columns for synthetic PK.
        if (srcTable.getColDefs().containsKey(colId)) {
          cols.put(
              srcTable.getColDefs().get(colId).getName(),
              spTable.getColDefs().get(colId).getName());
        }
      }
      NameAndCols nameAndCols = new NameAndCols(spTable.getName(), cols);
      this.toSpanner.put(srcTable.getName(), nameAndCols);
    }
  }

  public void computeToSource() {
    // We iterate over spSchema because srcSchema might have extra tables that were dropped.
    for (String tableId : spSchema.keySet()) {
      SpannerTable spTable = spSchema.get(tableId);
      SourceTable srcTable = srcSchema.get(tableId);
      Map<String, String> cols = new HashMap<String, String>();
      // We iterate over spTable columns because the source might have extra columns that were
      // dropped. We only keep those columns present both in source and in spanner.
      for (String colId : spTable.getColIds()) {
        // We add this check because spanner can have extra columns for synthetic PK.
        if (srcTable.getColDefs().containsKey(colId)) {
          cols.put(
              spTable.getColDefs().get(colId).getName(),
              srcTable.getColDefs().get(colId).getName());
        }
      }
      NameAndCols nameAndCols = new NameAndCols(srcTable.getName(), cols);
      this.toSource.put(spTable.getName(), nameAndCols);
    }
  }

  public void computeSrcToID() {
    for (String tableId : srcSchema.keySet()) {
      SourceTable srcTable = srcSchema.get(tableId);
      Map<String, String> cols = new HashMap<String, String>();
      for (String colId : srcTable.getColIds()) {
        cols.put(srcTable.getColDefs().get(colId).getName(), colId);
      }
      NameAndCols nameAndCols = new NameAndCols(tableId, cols);
      this.srcToID.put(srcTable.getName(), nameAndCols);
    }
  }

  public void computeSpannerToID() {
    for (String tableId : spSchema.keySet()) {
      SpannerTable spTable = spSchema.get(tableId);
      Map<String, String> cols = new HashMap<String, String>();
      for (String colId : spTable.getColIds()) {
        cols.put(spTable.getColDefs().get(colId).getName(), colId);
      }
      NameAndCols nameAndCols = new NameAndCols(tableId, cols);
      this.spannerToID.put(spTable.getName(), nameAndCols);
    }
  }

  /** Verify if given table name is valid in the session file. */
  public void verifyTableInSession(String tableName)
      throws IllegalArgumentException, DroppedTableException {
    if (!this.srcToID.containsKey(tableName)) {
      throw new IllegalArgumentException(
          "Missing entry for " + tableName + " in srcToId map, provide a valid session file.");
    }
    if (!this.toSpanner.containsKey(tableName)) {
      throw new DroppedTableException(
          "Cannot find entry for "
              + tableName
              + " in toSpanner map, it is likely this table was dropped");
    }
    String tableId = this.srcToID.get(tableName).getName();
    if (!this.spSchema.containsKey(tableId)) {
      throw new IllegalArgumentException(
          "Missing entry for " + tableId + " in spSchema, provide a valid session file.");
    }
  }

  /** Returns the list of all the columns names in Spanner. */
  public List<String> getSpannerColumnNames(String spannerTableName) throws NoSuchElementException {
    if (this.spannerToID.get(spannerTableName) == null) {
      throw new NoSuchElementException(
          String.format("Table '%s' does not exist.", spannerTableName));
    }
    String tableId = this.spannerToID.get(spannerTableName).getName();
    List<String> colIds = Arrays.asList(this.spSchema.get(tableId).getColIds());
    Map<String, SpannerColumnDefinition> colDefs = this.spSchema.get(tableId).getColDefs();
    List<String> colNames =
        colIds.stream().map(colId -> colDefs.get(colId).getName()).collect(Collectors.toList());
    return colNames;
  }

  public boolean isEmpty() {
    return empty;
  }

  public void setEmpty(boolean empty) {
    this.empty = empty;
  }

  public String toString() {
    return String.format(
        "{ 'spSchema': '%s', 'syntheticPKeys': '%s', 'srcSchema': '%s', 'toSpanner':"
            + " '%s', 'toSource': '%s', 'srcToID': '%s', 'spannerToID': '%s', 'empty': '%s' }",
        spSchema, syntheticPKeys, srcSchema, toSpanner, toSource, srcToID, spannerToID, empty);
  }

  @Override
  public boolean equals(Object o) {
    if (o == this) {
      return true;
    }
    if (!(o instanceof Schema)) {
      return false;
    }
    final Schema other = (Schema) o;
    return this.empty == other.empty
        && this.spSchema.equals(other.spSchema)
        && this.syntheticPKeys.equals(other.syntheticPKeys)
        && this.srcSchema.equals(other.srcSchema);
  }

  @Override
  public int hashCode() {
    return Objects.hash(empty, spSchema, syntheticPKeys, srcSchema);
  }
}
