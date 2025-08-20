unit DataSet.Serialize;

{$IF DEFINED(FPC)}
{$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses
{$IF DEFINED(FPC)}
  DB, fpjson,
{$ELSE}
  System.JSON, Data.DB, System.Variants, FireDAC.Comp.Client,
{$ENDIF}
  DataSet.Serialize.Language, DataSet.Serialize.Config;

type
  TLanguageType = DataSet.Serialize.Language.TLanguageType;
  TDataSetSerializeConfig = DataSet.Serialize.Config.TDataSetSerializeConfig;
  TCaseNameDefinition = DataSet.Serialize.Config.TCaseNameDefinition;

  TDataSetSerializeHelper = class Helper for TDataSet
  public
    /// <summary>
    /// Creates a JSON object with the data from the current record of DataSet.
    /// </summary>
    /// <param name="AOnlyUpdatedRecords">
    /// Exports only inserted, modified and deleted data from childs dataset.
    /// </param>
    /// <param name="AChildRecords">
    /// Exports only childs records from child datasets.
    /// </param>
    /// <param name="AValueRecords">
    /// Inform if it's to export only field values (when there is only 1 field in the DataSet)
    /// </param>
    /// <param name="AEncodeBase64Blob">
    /// Convert blob fields to base64.
    /// </param>
    /// <returns>
    /// Returns a JSON string containing the record data.
    /// </returns>
    /// <remarks>
    /// Invisible fields will not be generated.
    /// </remarks>
    function ToJSONObjectString(const AOnlyUpdatedRecords: Boolean = False; const AChildRecords: Boolean = True;
      const AValueRecords: Boolean = True; const AEncodeBase64Blob: Boolean = True): string;
    /// <summary>
    /// Creates an array of JSON objects with all DataSet records.
    /// </summary>
    /// <param name="AOnlyUpdatedRecords">
    /// Exports only inserted, modified and deleted data from childs dataset.
    /// </param>
    /// <param name="AChildRecords">
    /// Exports only childs records from child datasets.
    /// </param>
    /// <param name="AValueRecords">
    /// Inform if it's to export only field values (when there is only 1 field in the DataSet)
    /// </param>
    /// <param name="AEncodeBase64Blob">
    /// Convert blob fields to base64.
    /// </param>
    /// <returns>
    /// Returns a JSON string with all records from the DataSet.
    /// </returns>
    /// <remarks>
    /// Invisible fields will not be generated.
    /// </remarks>
    function ToJSONArrayString(const AOnlyUpdatedRecords: Boolean = False; const AChildRecords: Boolean = True;
      const AValueRecords: Boolean = True; const AEncodeBase64Blob: Boolean = True): string;
    /// <summary>
    /// Creates a JSON object with the data from the current record of DataSet.
    /// </summary>
    /// <param name="AOnlyUpdatedRecords">
    /// Exports only inserted, modified and deleted data from childs dataset.
    /// </param>
    /// <param name="AChildRecords">
    /// Exports only childs records from child datasets.
    /// </param>
    /// <param name="AValueRecords">
    /// Inform if it's to export only field values (when there is only 1 field in the DataSet)
    /// </param>
    /// <param name="AEncodeBase64Blob">
    /// Convert blob fields to base64.
    /// </param>
    /// <returns>
    /// Returns a JSON object containing the record data.
    /// </returns>
    /// <remarks>
    /// Invisible fields will not be generated.
    /// </remarks>
    function ToJSONObject(const AOnlyUpdatedRecords: Boolean = False; const AChildRecords: Boolean = True;
      const AValueRecords: Boolean = True; const AEncodeBase64Blob: Boolean = True): TJSONObject;
    /// <summary>
    /// Creates an array of JSON objects with all DataSet records.
    /// </summary>
    /// <param name="AOnlyUpdatedRecords">
    /// Exports only inserted, modified and deleted data from childs dataset.
    /// </param>
    /// <param name="AChildRecords">
    /// Exports only childs records from child datasets.
    /// </param>
    /// <param name="AValueRecords">
    /// Inform if it's to export only field values (when there is only 1 field in the DataSet)
    /// </param>
    /// <param name="AEncodeBase64Blob">
    /// Convert blob fields to base64.
    /// </param>
    /// <returns>
    /// Returns a JSONArray with all records from the DataSet.
    /// </returns>
    /// <remarks>
    /// Invisible fields will not be generated.
    /// </remarks>
    function ToJSONArray(const AOnlyUpdatedRecords: Boolean = False; const AChildRecords: Boolean = True;
      const AValueRecords: Boolean = True; const AEncodeBase64Blob: Boolean = True): TJSONArray;
    /// <summary>
    /// Responsible for exporting the structure of a DataSet in JSON Array format.
    /// </summary>
    /// <returns>
    /// Returns a JSON array with all fields of the DataSet.
    /// </returns>
    /// <remarks>
    /// Invisible fields will not be generated.
    /// </remarks>
    function SaveStructure: TJSONArray;
    function SaveStructureString: string;
    /// <summary>
    /// Loads fields from a DataSet based on a JSONArray.
    /// </summary>
    /// <param name="AJSONArray">
    /// Refers to JSON with field specifications.
    /// </param>
    /// <param name="AOwns">
    /// Destroy JSON in the end.
    /// </param>
    procedure LoadStructure(const AJSONArray: TJSONArray; const AOwns: Boolean = True); overload;
    /// <summary>
    /// Loads fields from a DataSet based on a JSON (string format).
    /// </summary>
    /// <param name="AJSONString">
    /// Refers to JSON with field specifications.
    /// </param>
    procedure LoadStructure(const AJSONString: string); overload;
    /// <summary>
    /// Loads the DataSet with data from a JSON object.
    /// </summary>
    /// <param name="AJSONObject">
    /// Refers to JSON that you want to load.
    /// </param>
    /// <param name="AOwns">
    /// Destroy JSON in the end.
    /// </param>
    /// <remarks>
    /// Only the keys that make up the DataSet field list will be loaded. The JSON keys must have the same name as the
    /// DataSet fields. It's not case-sensitive.
    /// </remarks>
    procedure LoadFromJSON(const AJSONObject: TJSONObject; const AOwns: Boolean = True); overload;
    /// <summary>
    /// Loads the DataSet with data from a JSON Array.
    /// </summary>
    /// <param name="AJSONArray">
    /// Refers to JSON that you want to load.
    /// </param>
    /// <remarks>
    /// Only the keys that make up the DataSet field list will be loaded. The JSON keys must have the same name as the
    /// DataSet fields. It's not case-sensitive.
    /// </remarks>
    procedure LoadDataFromJSON(const AJSONArray: TJSONArray); overload;
    /// <summary>
    /// Loads the DataSet with data from a JSON object.
    /// </summary>
    /// <param name="AJSONObject">
    /// Refers to JSON that you want to load.
    /// </param>
    /// <param name="ARootElement">
    /// Elemento raiz do JSON
    /// </param>
    /// <param name="AOwns">
    /// Destroy JSON in the end.
    /// </param>
    /// <remarks>
    /// Only the keys that make up the DataSet field list will be loaded. The JSON keys must have the same name as the
    /// DataSet fields. It's not case-sensitive.
    /// </remarks>
    procedure LoadFromJSON(const AJSONObject: TJSONObject; const ARootElement: string;
      const AOwns: Boolean = True); overload;
    /// <summary>
    /// Loads the DataSet with data from a JSON array.
    /// </summary>
    /// <param name="AJSONArray">
    /// Refers to JSON that you want to load.
    /// </param>
    /// <param name="AOwns">
    /// Destroy JSON in the end.
    /// </param>
    /// <remarks>
    /// Only the keys that make up the DataSet field list will be loaded. The JSON keys must have the same name as the
    /// DataSet fields. It's not case-sensitive.
    /// </remarks>
    procedure LoadFromJSON(const AJSONArray: TJSONArray; const AOwns: Boolean = True); overload;
    /// <summary>
    /// Loads the DataSet with data from a JSON (string format).
    /// </summary>
    /// <param name="AJSONString">
    /// Refers to JSON that you want to load.
    /// </param>
    /// <param name="ARootElement">
    /// Elemento raiz do JSON
    /// </param>
    /// <remarks>
    /// Only the keys that make up the DataSet field list will be loaded. The JSON keys must have the same name as the
    /// DataSet fields. It's not case-sensitive.
    /// </remarks>
    procedure LoadFromJSON(const AJSONString: string; const ARootElement: string = ''); overload;
    /// <summary>
    /// Updates the DataSet data with JSON object data.
    /// </summary>
    /// <param name="AJSONObject">
    /// Refers to JSON that you want to merge.
    /// </param>
    /// <param name="AOwns">
    /// Destroy JSON in the end.
    /// </param>
    procedure MergeFromJSONObject(const AJSONObject: TJSONObject; const AOwns: Boolean = True); overload;
    /// <summary>
    /// Updates the DataSet data with JSON object data (string format).
    /// </summary>
    /// <param name="AJSONString">
    /// Refers to JSON that you want to merge.
    /// </param>
    procedure MergeFromJSONObject(const AJSONString: string); overload;
    /// <summary>
    /// Responsible for validating whether JSON has all the necessary information for a particular DataSet.
    /// </summary>
    /// <param name="AJSONObject">
    /// Refers to JSON that must be validated.
    /// </param>
    /// <param name="ALang">
    /// Language used to mount messages.
    /// </param>
    /// <param name="AOwns">
    /// Destroy JSON in the end.
    /// </param>
    /// <returns>
    /// Returns a JSONArray with the fields that were not informed.
    /// </returns>
    /// <remarks>
    /// Walk the DataSet fields by checking the required property.
    /// Uses the DisplayLabel property to mount the message.
    /// </remarks>
    function ValidateJSON(const AJSONObject: TJSONObject; const ALang: TLanguageType = enUS;
      const AOwns: Boolean = True): TJSONArray; overload;
    /// <summary>
    /// Responsible for validating whether JSON has all the necessary information for a particular DataSet.
    /// </summary>
    /// <param name="AJSONString">
    /// Refers to JSON that must be validated.
    /// </param>
    /// <param name="ALang">
    /// Language used to mount messages.
    /// </param>
    /// <returns>
    /// Returns a JSONArray with the fields that were not informed.
    /// </returns>
    /// <remarks>
    /// Walk the DataSet fields by checking the required property.
    /// Uses the DisplayLabel property to mount the message.
    /// </remarks>
    function ValidateJSON(const AJSONString: string; const ALang: TLanguageType = enUS): TJSONArray; overload;
  end;

implementation

uses
{$IF DEFINED(FPC)}
  SysUtils,
{$ELSE}
  System.SysUtils,
{$ENDIF}
  DataSet.Serialize.Export, DataSet.Serialize.Import;

function TDataSetSerializeHelper.ToJSONArray(const AOnlyUpdatedRecords: Boolean = False;
  const AChildRecords: Boolean = True; const AValueRecords: Boolean = True; const AEncodeBase64Blob: Boolean = True)
  : TJSONArray;
var
  LDataSetSerialize: TDataSetSerialize;
begin
  LDataSetSerialize := TDataSetSerialize.Create(Self, AOnlyUpdatedRecords, AChildRecords, AValueRecords,
    AEncodeBase64Blob);
  try
    Result := LDataSetSerialize.ToJSONArray;
  finally
    LDataSetSerialize.Free;
  end;
end;

function TDataSetSerializeHelper.ToJSONObject(const AOnlyUpdatedRecords: Boolean = False;
  const AChildRecords: Boolean = True; const AValueRecords: Boolean = True; const AEncodeBase64Blob: Boolean = True)
  : TJSONObject;
var
  LDataSetSerialize: TDataSetSerialize;
begin
  LDataSetSerialize := TDataSetSerialize.Create(Self, AOnlyUpdatedRecords, AChildRecords, AValueRecords,
    AEncodeBase64Blob);
  try
    Result := LDataSetSerialize.ToJSONObject;
  finally
    LDataSetSerialize.Free;
  end;
end;

function TDataSetSerializeHelper.ToJSONObjectString(const AOnlyUpdatedRecords: Boolean = False;
  const AChildRecords: Boolean = True; const AValueRecords: Boolean = True;
  const AEncodeBase64Blob: Boolean = True): string;
var
  LJSONObject: TJSONObject;
begin
  LJSONObject := Self.ToJSONObject(AOnlyUpdatedRecords, AChildRecords, AValueRecords, AEncodeBase64Blob);
  try
    Result := {$IF DEFINED(FPC)}LJSONObject.AsJSON{$ELSE}LJSONObject.ToString{$ENDIF};
  finally
    LJSONObject.Free;
  end;
end;

function TDataSetSerializeHelper.ToJSONArrayString(const AOnlyUpdatedRecords: Boolean = False;
  const AChildRecords: Boolean = True; const AValueRecords: Boolean = True;
  const AEncodeBase64Blob: Boolean = True): string;
var
  LJSONArray: TJSONArray;
begin
  LJSONArray := Self.ToJSONArray(AOnlyUpdatedRecords, AChildRecords, AValueRecords, AEncodeBase64Blob);
  try
    Result := {$IF DEFINED(FPC)}LJSONArray.AsJSON{$ELSE}LJSONArray.ToString{$ENDIF};
  finally
    LJSONArray.Free;
  end;
end;

function TDataSetSerializeHelper.SaveStructure: TJSONArray;
var
  LDataSetSerialize: TDataSetSerialize;
begin
  LDataSetSerialize := TDataSetSerialize.Create(Self);
  try
    Result := LDataSetSerialize.SaveStructure;
  finally
    LDataSetSerialize.Free;
  end;
end;

function TDataSetSerializeHelper.SaveStructureString: string;
var
  LJSONArray: TJSONArray;
begin
  LJSONArray := Self.SaveStructure;
  try
    Result := {$IF DEFINED(FPC)}LJSONArray.AsJSON{$ELSE}LJSONArray.ToString{$ENDIF};
  finally
    LJSONArray.Free;
  end;
end;

function TDataSetSerializeHelper.ValidateJSON(const AJSONObject: TJSONObject; const ALang: TLanguageType = enUS;
  const AOwns: Boolean = True): TJSONArray;
var
  LJSONSerialize: TJSONSerialize;
begin
  LJSONSerialize := TJSONSerialize.Create(AJSONObject, AOwns);
  try
    Result := LJSONSerialize.Validate(Self, ALang);
  finally
    LJSONSerialize.Free;
  end;
end;

procedure TDataSetSerializeHelper.LoadFromJSON(const AJSONArray: TJSONArray; const AOwns: Boolean = True);
var
  LJSONSerialize: TJSONSerialize;
begin
  LJSONSerialize := TJSONSerialize.Create(AJSONArray, AOwns);
  try
    LJSONSerialize.ToDataSet(Self);
  finally
    LJSONSerialize.Free;
  end;
end;

procedure TDataSetSerializeHelper.LoadFromJSON(const AJSONObject: TJSONObject; const AOwns: Boolean = True);
begin
  LoadFromJSON(AJSONObject, EmptyStr, AOwns);
end;

procedure TDataSetSerializeHelper.LoadDataFromJSON(const AJSONArray: TJSONArray);
var
  JSONObject: TJsonObject;
  Pair: TJsonPair;
  FieldName: String;
  I, J: integer;
  Value: TJsonValue;
begin
  if not self.Active then
  begin
    self.Active := true;
  end;
{$IFDEF DEFINED(FPC)}
  self.First;
  while not self.Eof do
  begin
    self.Delete;
  end;
{$ELSE}
  if Self is TFDMemTable then
  begin
    (Self as TFDMemTable).EmptyDataSet;
  end
  else
  begin
    self.First;
    while not self.Eof do
    begin
      self.Delete;
    end;
  end;;
{$ENDIF}
  self.Close;
  self.Open;
  for I := 0 to AJSONArray.Count - 1 do
  begin
    self.Append;
    JSONObject := AJSONArray.Items[I] as TJsonObject;
    for J := 0 to JSONObject.Count - 1 do
    begin
      Pair := JSONObject.Pairs[J];
      FieldName := Pair.JsonString.Value;
      Value := Pair.JsonValue;
      if Assigned(Value) then
      begin
        // 根据字段类型赋值
        case self.FieldByName(FieldName).DataType of
          ftLargeint:
            begin
              if Value is TJsonNull then
                self.FieldByName(FieldName).AsLargeInt := 0
              else
                self.FieldByName(FieldName).AsLargeInt := Value.GetValue<LongInt>;
            end;
          ftSmallint, ftInteger, ftWord, ftShortint:
            begin
              if Value is TJsonNull then
                self.FieldByName(FieldName).AsInteger := 0
              else
                self.FieldByName(FieldName).AsInteger := Value.GetValue<Integer>;
            end;
          ftLongWord:
            self.FieldByName(FieldName).AsLongWord := Value.GetValue<LongWord>;
          ftSingle:
            begin
              if Value is TJsonNull then
                self.FieldByName(FieldName).AsSingle := 0
              else
                self.FieldByName(FieldName).AsSingle := Value.GetValue<Single>;
            end;

          ftFloat:
            begin
              if Value is TJsonNull then
                self.FieldByName(FieldName).AsFloat := 0
              else
                self.FieldByName(FieldName).AsFloat := Value.GetValue<Double>;
            end;
          ftCurrency:
            self.FieldByName(FieldName).AsCurrency := Value.GetValue<Currency>;
          ftBoolean:
            self.FieldByName(FieldName).AsBoolean := Value.GetValue<Boolean>;
          ftDateTime:
            self.FieldByName(FieldName).AsDateTime := Value.GetValue<TDateTime>;
          ftString:
            self.FieldByName(FieldName).AsString := Value.GetValue<string>;
        else
          self.FieldByName(FieldName).AsWideString := Value.Value; // 处理字符串和未知类型
        end;
      end
      else
      begin
        self.FieldByName(FieldName).AsVariant := Null;
      end;
    end;
  end;
  if Self.Modified then
    self.Post;
  self.First;
end;

procedure TDataSetSerializeHelper.LoadFromJSON(const AJSONObject: TJSONObject; const ARootElement: string;
  const AOwns: Boolean = True);
var
  LJSON: {$IF DEFINED(FPC)}TJSONData{$ELSE}TJSONValue{$ENDIF};
  LJSONSerialize: TJSONSerialize;
begin
  if ARootElement.Trim.IsEmpty then
    LJSONSerialize := TJSONSerialize.Create(AJSONObject, AOwns)
  else
  begin
    LJSON := nil;
    try
{$IF DEFINED(FPC)}
      LJSON := AJSONObject.Find(ARootElement);
{$ELSE}
{$IF COMPILERVERSION <= 32}
      if not AJSONObject.TryGetValue<TJSONValue>(ARootElement, LJSON) then
        LJSON := nil;
{$ELSE}
      LJSON := AJSONObject.FindValue(ARootElement);
{$IFEND}
{$ENDIF}
      if Assigned(LJSON) then
      begin
        if LJSON.InheritsFrom(TJSONArray) then
          LJSONSerialize := TJSONSerialize.Create(LJSON.Clone as TJSONArray, True)
        else
          LJSONSerialize := TJSONSerialize.Create(LJSON.Clone as TJSONObject, True);
      end
      else
        LJSONSerialize := TJSONSerialize.Create(AJSONObject, AOwns);
    finally
      if AOwns and Assigned(LJSON) then
        AJSONObject.Free;
    end;
  end;
  try
    LJSONSerialize.ToDataSet(Self);
  finally
    LJSONSerialize.Free;
  end;
end;

procedure TDataSetSerializeHelper.LoadStructure(const AJSONArray: TJSONArray; const AOwns: Boolean = True);
var
  LJSONSerialize: TJSONSerialize;
begin
  LJSONSerialize := TJSONSerialize.Create(AJSONArray, AOwns);
  try
    LJSONSerialize.LoadStructure(Self);
  finally
    LJSONSerialize.Free;
  end;
end;

procedure TDataSetSerializeHelper.MergeFromJSONObject(const AJSONObject: TJSONObject; const AOwns: Boolean = True);
var
  LJSONSerialize: TJSONSerialize;
begin
  LJSONSerialize := TJSONSerialize.Create(AJSONObject, AOwns);
  try
    LJSONSerialize.Merge(Self);
  finally
    LJSONSerialize.Free;
  end;
end;

function TDataSetSerializeHelper.ValidateJSON(const AJSONString: string; const ALang: TLanguageType): TJSONArray;
begin
  if Trim(AJSONString).StartsWith('{') then
    Result := ValidateJSON({$IF DEFINED(FPC)}GetJSON(AJSONString){$ELSE}TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(AJSONString), 0){$ENDIF} as TJSONObject, ALang)
  else
    Result := TJSONArray.Create();
end;

procedure TDataSetSerializeHelper.LoadFromJSON(const AJSONString: string; const ARootElement: string = '');
begin
  if Trim(AJSONString).StartsWith('{') then
    LoadFromJSON({$IF DEFINED(FPC)}GetJSON(AJSONString){$ELSE}TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(AJSONString), 0){$ENDIF} as TJSONObject, ARootElement)
  else if Trim(AJSONString).StartsWith('[') then
    LoadFromJSON({$IF DEFINED(FPC)}GetJSON(AJSONString){$ELSE}TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(AJSONString), 0){$ENDIF} as TJSONArray);
end;

procedure TDataSetSerializeHelper.LoadStructure(const AJSONString: string);
begin
  if Trim(AJSONString).StartsWith('[') then
    LoadStructure({$IF DEFINED(FPC)}GetJSON(AJSONString){$ELSE}TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(AJSONString), 0){$ENDIF} as TJSONArray);
end;

procedure TDataSetSerializeHelper.MergeFromJSONObject(const AJSONString: string);
begin
  if Trim(AJSONString).StartsWith('{') then
    MergeFromJSONObject({$IF DEFINED(FPC)}GetJSON(AJSONString){$ELSE}TJSONObject.ParseJSONValue
      (TEncoding.UTF8.GetBytes(AJSONString), 0){$ENDIF} as TJSONObject)
end;

end.
