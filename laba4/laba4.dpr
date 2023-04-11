program laba4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  PStack = ^TStack;
  TStack = record
    Letter: Char;
    Next: PStack;
  end;

var
  Top: PStack;
  ResultString, KeyString: String;
  Rang, i: Integer;

procedure Push(const Value: Char; var Top: PStack);
var
  Temp: PStack;
begin
  New(Temp);
  Temp^.Letter := Value;
  Temp^.Next := Top;
  Top := Temp;
end;

function Pop(var Top: PStack): Char;
var
  Temp: PStack;
begin
  Result := Top^.Letter;
  Temp := Top;
  Top := Top^.Next;
  Dispose(Temp);
end;

procedure Show(const Top: PStack);
var
  Temp: PStack;
begin
  Temp := Top;
  while Temp <> nil do
  begin
    Write(Temp^.Letter, ' ');
    Temp := Temp^.Next;
  end;
end;

function Peek(const Top: PStack): Char;
begin
  Result := Top^.Letter;
end;

function IsEmpty(const Top: PStack): Boolean;
begin
  Result := Top = nil;
end;

procedure Clear(var Top: PStack);
begin
  while not IsEmpty(Top) do Pop(Top);
end;

function GetPriorityOtn(const C: Char): Integer;
begin
  Result := 0;
  case C of
    '(': Result := 9;
    '+', '-': Result := 1;
    '*', '/': Result := 3;
    '^' : Result := 6;
    'a'..'z', 'A'..'Z': Result := 7;
    ')': result := 0;
  end;
end;

function GetPriorityStack(const C: Char): Integer;
begin
  Result := 0;
  case C of
    '(': Result := 0;
    '+', '-': Result := 2;
    '*', '/': Result := 4;
    '^' : Result := 5;
    'a'..'z', 'A'..'Z': Result := 8;
  end;
end;

function GetRang(const C: Char): Integer;
begin
  case C of
    'a'..'z', 'A'..'Z': Result := 1;
  else
    Result := -1;
  end;
end;

function ReversePolishEntry(var Key: String; var Rang: Integer; var Top: PStack): String;
var
  i, AbsCf, OtnCf: Integer;
begin
  Rang := 0;
  Push(Key[1], Top);
  i := 2;
  Result := '';
  while i <= length(Key) do
  begin
    if Key[i] = ')' then
    begin
      repeat
        Rang := Rang + GetRang(Peek(Top));
        Result := Result + Pop(Top);
      until Peek(Top) ='(';
      Pop(Top);
      Inc(i);
    end
    else
    begin
      AbsCf := GetPriorityStack(Peek(Top));
      OtnCf := GetPriorityOtn(Key[i]);
      if OtnCf > AbsCf  then
      begin
        Push(Key[i], Top);
        Inc(i);
      end
      else
      begin
        Rang := Rang + GetRang(Peek(Top));
        Result := Result + Pop(Top);
      end;
    end;
  end;
  repeat
    Rang := Rang + GetRang(Peek(Top));
    Result := Result + Pop(Top);
  until Top = nil;
  Inc(Rang);
end;

begin
  Write('Enter the string: ');
  ReadLn(KeyString);
  New(Top);
  Top^.Next := nil;

  ResultString := ReversePolishEntry(KeyString, Rang, Top);

  WriteLn('Result string: ', ResultString);
  WriteLn('Rang: ', Rang);
  ReadLn;
end.
