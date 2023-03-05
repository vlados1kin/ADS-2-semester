program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.sysUtils;

type
  pt = ^elem;
  elem = record
    Number: integer;
    Next: pt;
  end;

var
  Circle: pt;
  N, K: integer;

procedure MakeCircle(var Circle: pt; const N: integer);
var
  I: integer;
  Header: pt;
begin
  New(Header);
  Circle := Header;
  Header^.Number := 1;
  for I := 2 to N do
  begin
    New(Circle^.Next);
    Circle := Circle^.Next;
    Circle^.Number := I;
  end;
  Circle^.Next := Header;
end;

procedure ResultGame(var Circle: pt; const K: integer);
var
  I: integer;
  Str: string;
  Temp: pt;
begin
  while Circle^.Next <> Circle do
  begin
    for I := 1 to K - 1 do
      Circle := Circle^.Next;
    Temp := Circle^.Next;
    Str := Str + IntToStr(Temp.Number) + ' ';
    Circle^.Next := Temp^.Next;
    Dispose(Temp);
  end;
  WriteLn('Остался: '+ IntToStr(Circle^.Number));
  WriteLn('Удалены: ' + Str);
end;

procedure Input(var N, K: integer);
var
  IsCorrect: boolean;
begin
  repeat
    IsCorrect := true;
    Write('Введите N: ');
    ReadLn(N);
    Write('Введите K: ');
    ReadLn(K);
    if (N <= 0) or (K <= 0) then
      IsCorrect := false;
    if not IsCorrect then
      WriteLn('Некорректный ввод');
  until IsCorrect;
end;

begin
  Input(N, K);
  MakeCircle(Circle, N);
  ResultGame(Circle, K);
  ReadLn;
end.
